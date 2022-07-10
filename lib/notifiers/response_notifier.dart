import 'package:flutter/material.dart';
import 'package:reading_wucc/models/models.dart';

class ResponseNotifier extends ChangeNotifier {
  List<Response>? _allResponses;
  List<Response>? _myResponses;
  List<Response>? _allResponsesForMember;
  List<List<Response>>? _responseEachDay;
  Response? _currentResponse;

  List<Response>? get allResponses => _allResponses;
  List<Response>? get myResponses => _myResponses;
  List<List<Response>>? get responseEachDay => _responseEachDay;
  Response? get currentResponse => _currentResponse;
  List<Response>? get allResponsesForMember => _allResponsesForMember;

  set setAllResponses(List<Response> allResponses) {
    _allResponses = allResponses;
    notifyListeners();
  }

  set setMyResponses(List<Response> myResponses) {
    _myResponses = myResponses;
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
}
