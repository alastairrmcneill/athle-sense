import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/services/auth_service.dart';

class UserNotifier extends ChangeNotifier {
  AppUser? _currentUser;

  UserNotifier(User? user) {
    if (user != null) {
      _currentUser = AppUser(uid: user.uid, events: []);
      return;
    }
    _currentUser = null;
  }

  AppUser? get currentUser => _currentUser;

  set setCurrentUser(AppUser? currentUser) {
    _currentUser = currentUser;
    notifyListeners();
  }
}
