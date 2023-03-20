import 'package:flutter/material.dart';
import 'package:wellness_tracker/models/models.dart';

class EventNotifier extends ChangeNotifier {
  List<Event>? _userEvents;
  Event? _currentEvent;
  List<Member>? _currentEventMembers;

  List<Event>? get userEvents => _userEvents;
  Event? get currentEvent => _currentEvent;
  List<Member>? get currentEventMembers => _currentEventMembers;

  set setUserEvents(List<Event> userEvents) {
    _userEvents = userEvents;
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
