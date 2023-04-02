import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth user stream
  Stream<AppUser?> get appUserStream {
    return _auth.authStateChanges().map((User? user) => _appUserFromFirebaseUser(user));
  }

  // Get the current logged in user for provider

  static Future getCurrentUser(UserNotifier userNotifier) async {
    AppUser? appUser = _appUserFromFirebaseUser(_auth.currentUser);

    userNotifier.setCurrentUser = appUser;
  }

  // Current user id
  static String? get currentUserId {
    return _auth.currentUser?.uid;
  }

  // Register with email

  static Future registerWithEmailAndPassword(UserNotifier userNotifier, AppUser appUser, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      AppUser newAppUser = appUser.copy(uid: user!.uid);

      // Create user record in database
      await UserDatabase.createUserRecord(newAppUser).whenComplete(() {
        userNotifier.setCurrentUser = newAppUser;
      });
      return newAppUser;
    } on FirebaseAuthException catch (error) {
      return _customErrorFromFirebaseAuthException(error);
    } on FirebaseException catch (error) {
      return _customErrorFromFirebaseException(error);
    }
  }

  // Register gmail

  // Register with facebook

  // Sign in with email and password
  static Future signInWithEmailPassword(UserNotifier userNotifier, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user != null) {
        AppUser? appUser = await UserDatabase.getUser(user.uid);
        if (appUser != null) {
          userNotifier.setCurrentUser = appUser;
          return appUser;
        }
      }
      return null;
    } on FirebaseAuthException catch (error) {
      return _customErrorFromFirebaseAuthException(error);
    } on FirebaseException catch (error) {
      return _customErrorFromFirebaseException(error);
    }
  }

  // Forgot password
  static Future forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (error) {
      return _customErrorFromFirebaseAuthException(error);
    }
  }

  // Sign out
  static Future signOut(BuildContext context) async {
    clearNotifiers(context);
    await PurchasesService.logout(context);
    await _auth.signOut();
  }

  // Delete account
  static Future delete(BuildContext context) async {
    User user = _auth.currentUser!;
    String uid = user.uid;

    await user.delete();

    await UserDatabase.deleteUser(uid);
    // await EventDatabase.removeUserFromEvents(uid);
    await ResponseDatabase.deleteUserResponses(uid);

    clearNotifiers(context);
  }

  static clearNotifiers(BuildContext context) {
    // Clear the notifiers
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context, listen: false);
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);

    userNotifier.setCurrentUser = null;
    responseNotifier.setMyResponses = null;
    eventNotifier.setMyEvents = null;
  }

  // AppUser from Firebase user
  static AppUser? _appUserFromFirebaseUser(User? user) {
    return (user != null) ? AppUser(uid: user.uid) : null;
  }

  // Decoupling firebase service and main app by setting custom errors for auth service
  static CustomError _customErrorFromFirebaseAuthException(FirebaseAuthException error) {
    return CustomError(code: error.code, message: error.message!);
  }

  // Decoupling firebase service and main app by setting custom errors for auth service
  static CustomError _customErrorFromFirebaseException(FirebaseException error) {
    return CustomError(code: error.code, message: error.message!);
  }
}
