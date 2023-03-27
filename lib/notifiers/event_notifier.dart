import 'package:flutter/material.dart';
import 'package:wellness_tracker/models/models.dart';

class EventNotifier extends ChangeNotifier {
  List<Event>? _myEvents;
  Event? _currentEvent;
  List<Member>? _currentEventMembers;

  List<Event>? get myEvents => _myEvents;
  Event? get currentEvent => _currentEvent;
  List<Member>? get currentEventMembers => _currentEventMembers;

  set setMyEvents(List<Event>? myEvents) {
    _myEvents = myEvents;
    notifyListeners();
  }

  set setCurrentEvent(Event currentEvent) {
    _currentEvent = currentEvent;
    notifyListeners();
  }

  set setCurrentEventMembers(List<Member> currentEventMembers) {
    _currentEventMembers = currentEventMembers;
    notifyListeners();
  }
}
