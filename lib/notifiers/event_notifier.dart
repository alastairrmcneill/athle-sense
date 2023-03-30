import 'package:flutter/material.dart';
import 'package:wellness_tracker/models/models.dart';

class EventNotifier extends ChangeNotifier {
  List<Event>? _myEvents;
  Event? _currentEvent;
  List<Member>? _currentEventMembers;
  EventData? _currentEventData;

  List<Event>? get myEvents => _myEvents;
  Event? get currentEvent => _currentEvent;
  List<Member>? get currentEventMembers => _currentEventMembers;
  EventData? get currentEventData => _currentEventData;

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

  setCurrentEventData(EventData? currentEventData, List<Member>? currentEventMembers) {
    _currentEventData = currentEventData;
    _currentEventMembers = currentEventMembers;
    notifyListeners();
  }
}
