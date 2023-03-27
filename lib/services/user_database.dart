import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';

class UserDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create
  static Future<void> createUserRecord(AppUser user) async {
    DocumentReference ref = _db.collection('Users').doc(user.uid);

    await ref.set(user.toJSON());
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

  static getCurrentUser(UserNotifier userNotifier) async {
    DocumentReference ref = _db.collection('Users').doc(AuthService.currentUserId!);

    DocumentSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

      AppUser user = AppUser.fromJSON(data);

      userNotifier.setCurrentUser = user;
    }
  }

  // Update
  static updateUser(UserNotifier userNotifier, AppUser user) async {
    DocumentReference ref = _db.collection('Users').doc(user.uid);

    await ref.update(user.toJSON());
    userNotifier.setCurrentUser = user;
  }

  // Delete
  static Future deleteUser(String uid) async {
    DocumentReference ref = _db.collection('Users').doc(uid);
    await ref.delete();
  }
}
