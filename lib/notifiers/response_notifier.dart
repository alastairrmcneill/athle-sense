import 'package:flutter/material.dart';
import 'package:reading_wucc/models/models.dart';

class ResponseNotifier extends ChangeNotifier {
  List<Response>? _allResponses;
  List<List<Response>>? _responseEachDay;
  Response? _currentResponse;

  List<Response>? get allResponses => _allResponses;
  List<List<Response>>? get responseEachDay => _responseEachDay;
  Response? get currentResponse => _currentResponse;

  set setAllResponses(List<Response> allResponses) {
    _allResponses = allResponses;
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
}
