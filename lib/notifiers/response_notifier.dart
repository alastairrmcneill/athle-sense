import 'package:flutter/material.dart';
import 'package:wellness_tracker/models/models.dart';

class ResponseNotifier extends ChangeNotifier {
  List<Response>? _allResponses;
  List<Response>? _myResponses;
  List<Response>? _myFilteredResponses;
  int _myResponseFilter = 2;
  List<Response>? _allResponsesForMember;
  List<List<Response>>? _responseEachDay;
  Response? _currentResponse;

  List<Response>? get allResponses => _allResponses;
  List<Response>? get myResponses => _myResponses;
  List<Response>? get myFilteredResponses => _myFilteredResponses;
  int get myResponseFilter => _myResponseFilter;
  List<List<Response>>? get responseEachDay => _responseEachDay;
  Response? get currentResponse => _currentResponse;
  List<Response>? get allResponsesForMember => _allResponsesForMember;

  set setAllResponses(List<Response> allResponses) {
    _allResponses = allResponses;
    notifyListeners();
  }

  set setMyResponses(List<Response>? myResponses) {
    _myResponses = myResponses;
    setMyResponsesFilter = _myResponseFilter;
    notifyListeners();
  }

  set setCurrentResponse(Response currentResponse) {
    _currentResponse = currentResponse;
    notifyListeners();
  }

  set setResponseEachDay(List<List<Response>> responseEachDay) {
    _responseEachDay = responseEachDay;
    notifyListeners();
  }

  set setAllResponsesForMember(List<Response> allResponsesForMember) {
    _allResponsesForMember = allResponsesForMember;
    notifyListeners();
  }

  set setMyResponsesFilter(int filter) {
    DateTime now = DateTime.now();

    _myResponseFilter = filter;
    if (filter == 0) {
      // Filter the last 3 months
      DateTime startDate = DateTime(now.year, now.month - 3, now.day);
      _myFilteredResponses = _myResponses?.where((response) => response.date.isAfter(startDate)).toList();
    } else if (filter == 1) {
      // Filter the last 12 months
      DateTime startDate = DateTime(now.year - 1, now.month, now.day);
      _myFilteredResponses = _myResponses?.where((response) => response.date.isAfter(startDate)).toList();
    } else {
      // Set all time
      _myFilteredResponses = _myResponses;
    }
    notifyListeners();
  }
}
