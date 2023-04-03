// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';
import 'package:wellness_tracker/support/wrapper.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth user stream
  Stream<AppUser?> get appUserStream {
    return _auth.authStateChanges().map((User? user) => _appUserFromFirebaseUser(user));
  }

  // Current user id
  static String? get currentUserId {
    return _auth.currentUser?.uid;
  }

  // Register with email
  static Future registerWithEmailAndPassword(BuildContext context, {required String name, required String email, required String password}) async {
    showCircularProgressOverlay(context);
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user == null) return;

      AppUser appUser = AppUser(
        uid: userCredential.user!.uid,
        name: name,
      );

      // Write to database

      // Create user record in database
      await UserDatabase.create(context, appUser: appUser);

      stopCircularProgressOverlay(context);

      // Push back to the wrapper
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (_) => false);
    } on FirebaseAuthException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There was an error registering your account.');
    }
  }

  // Sign in with email and password
  static Future signInWithEmailPassword(BuildContext context, {required String email, required String password}) async {
    showCircularProgressOverlay(context);
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      stopCircularProgressOverlay(context);
    } on FirebaseAuthException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There has been an error signing in.');
    }
  }

  // Forgot password
  static Future forgotPassword(BuildContext context, {required String email}) async {
    showCircularProgressOverlay(context);
    try {
      await _auth.sendPasswordResetEmail(email: email);
      stopCircularProgressOverlay(context);
      showSnackBar(context, 'Password retreival email sent.');
      return null;
    } on FirebaseAuthException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There has been an issue retreiving your email.');
    }
  }

  // Change password
  static Future changePassword(BuildContext context, {required String newPassword}) async {
    showCircularProgressOverlay(context);

    try {
      _auth.currentUser!.updatePassword(newPassword);
      stopCircularProgressOverlay(context);
      showSnackBar(context, 'Password successfully changed.');
      Navigator.pop(context);
    } on FirebaseAuthException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There was an error changing your password');
    }
  }

  // Validate password
  static Future<bool> validatePassword(BuildContext context, {required String password}) async {
    try {
      AuthCredential authCredential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: password,
      );
      UserCredential userCredential = await _auth.currentUser!.reauthenticateWithCredential(authCredential);

      return userCredential.user != null;
    } on FirebaseAuthException catch (error) {
      showErrorDialog(context, error.message ?? 'There was an error validating your password');
      return false;
    }
  }

  // Update username
  static Future updateUserName(BuildContext context, {required String name}) async {
    showCircularProgressOverlay(context);

    try {
      String? userUid = currentUserId;
      if (userUid == null) {
        stopCircularProgressOverlay(context);
        showErrorDialog(context, "Error: Logout and log back in to reset");
        return; // Return if not
      }

      AppUser newAppUser = AppUser(uid: userUid, name: name);

      // Write to database
      await UserDatabase.updateUser(context, newAppUser: newAppUser);

      // Update notifiers
      await UserDatabase.getCurrentUser(context);

      stopCircularProgressOverlay(context);
      showSnackBar(context, 'Name updated succesfully');
    } on FirebaseException catch (e) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, "There was an issue updating your user name.");
    }
  }

  // Sign out
  static Future signOut(BuildContext context) async {
    showCircularProgressOverlay(context);
    try {
      clearNotifiers(context);
      await PurchasesService.logout(context);
      await _auth.signOut();
      stopCircularProgressOverlay(context);
    } on FirebaseAuthException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There was an error signing out.');
    }
  }

  // Delete account
  static Future delete(BuildContext context) async {
    showCircularProgressOverlay(context);
    try {
      // Check if someone is logged in
      User? user = _auth.currentUser;
      if (user == null) return; // If not then return

      // Remove user from database
      await UserDatabase.deleteUser(context, uid: user.uid);

      // Delete User events
      await EventDatabase.deleteUserCreatedEvents(context, userId: user.uid);

      // Remove user from events
      EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
      for (var event in eventNotifier.myEvents ?? []) {
        await EventService.removeUserFromEvent(context, event: event, member: Member(uid: user.uid, name: 'name'));
      }

      // Delete user responses
      await ResponseDatabase.deleteUserResponses(context, uid: user.uid);

      // Sign out from firebase auth
      await user.delete();
      clearNotifiers(context);
      PurchasesService.logout(context);

      stopCircularProgressOverlay(context);

      // Push back to wrapper
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wrapper()), (_) => false);
    } on FirebaseAuthException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? "There has been an error deleting your account.");
    } on PlatformException catch (error) {
      stopCircularProgressOverlay(context);
      showErrorDialog(context, error.message ?? 'There was an error signing you out of the in app purchase tools.');
    }
  }

  // Clear data stored in app
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
}
