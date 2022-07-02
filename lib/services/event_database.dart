import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/services.dart';

class EventDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create
  static Future createEvent(UserNotifier userNotiifer, Event event) async {
    DocumentReference ref = _db.collection('Events').doc();

    Event newEvent = event.copy(uid: ref.id);

    await ref.set(newEvent.toJSON()).whenComplete(() async {
      AppUser user = userNotiifer.currentUser!;
      user.events.add(newEvent.uid!);

      await UserDatabase.updateUser(userNotiifer, user);
    });
  }

  // Read

  // Update

  // Delete

}
