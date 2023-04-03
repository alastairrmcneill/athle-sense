import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';

class UserDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _usersRef = _db.collection('Users');

  // Create
  static Future<void> create(BuildContext context, {required AppUser appUser}) async {
    // Write user to database
    try {
      DocumentReference ref = _usersRef.doc(appUser.uid);
      await ref.set(appUser.toJSON());
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  // Read

  static Future<AppUser?> getUser(String userID) async {
    DocumentReference ref = _db.collection('Users').doc(userID);

    DocumentSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

      AppUser user = AppUser.fromJSON(data);
      return user;
    }
    return null;
  }

  static Future<Member?> getMemberFromUID(String userID) async {
    DocumentReference ref = _db.collection('Users').doc(userID);

    DocumentSnapshot snapshot = await ref.get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

      Member member = Member.fromJSON(data);
      return member;
    }
    return null;
  }

  static getCurrentUser(BuildContext context) async {
    final AppUser? appUser = Provider.of<AppUser?>(context, listen: false);
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);

    // Check if user is lgoged in, return if not
    if (appUser == null) return;

    // Read the current user from database, convert to User model and add to provider
    try {
      DocumentReference ref = _usersRef.doc(appUser.uid);
      DocumentSnapshot snapshot = await ref.get();

      // Create app user
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
        AppUser user = AppUser.fromJSON(data);

        // Update notifier
        userNotifier.setCurrentUser = user;
      }
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  // Update
  static updateUser(BuildContext context, {required AppUser newAppUser}) async {
    // Update the user information in the firebase database
    try {
      DocumentReference ref = _usersRef.doc(newAppUser.uid);
      await ref.update(newAppUser.toJSON());
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message!);
    }
  }

  // Delete
  static Future deleteUser(BuildContext context, {required String uid}) async {
    try {
      DocumentReference ref = _db.collection('Users').doc(uid);
      await ref.delete();
    } on FirebaseException catch (error) {
      showErrorDialog(context, error.message ?? "There has been an error deleting your account from the database.");
    }
  }
}
