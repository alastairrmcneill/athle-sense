import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_wucc/models/models.dart';

class UserDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create
  static Future<void> createUserRecord(AppUser user) async {
    DocumentReference ref = _db.collection('Users').doc(user.uid);

    await ref.set(user.toJSON());
  }

  // Read

  // Update

  // Delete

}
