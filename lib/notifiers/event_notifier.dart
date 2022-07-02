import 'package:flutter/material.dart';
import 'package:reading_wucc/models/models.dart';

class EventNotifier extends ChangeNotifier {
  List<Event>? _userEvents;
  Event? _currentEvent;

  List<Event>? get userEvents => _userEvents;
  Event? get currentEvent => _currentEvent;

  set setUserEvents(List<Event> userEvents) {
    _userEvents = userEvents;
    notifyListeners();
  }

  set setCurrentEvent(Event currentEvent) {
    _currentEvent = currentEvent;
    notifyListeners();
  }
}
