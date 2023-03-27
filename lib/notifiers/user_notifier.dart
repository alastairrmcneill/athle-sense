import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/services/auth_service.dart';

class UserNotifier extends ChangeNotifier {
  AppUser? _currentUser;

  UserNotifier(User? user) {
    if (user != null) {
      _currentUser = AppUser(uid: user.uid);
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
