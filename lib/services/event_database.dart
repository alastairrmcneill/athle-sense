import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reading_wucc/models/models.dart';

class EventDatabase {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create
  static Future createEvent(Event event) async {
    DocumentReference ref = _db.collection('Events').doc();

    Event newEvent = event.copy(uid: ref.id);

    await ref.set(newEvent.toJSON());
  }

  // Read

  // Update

  // Delete

}
