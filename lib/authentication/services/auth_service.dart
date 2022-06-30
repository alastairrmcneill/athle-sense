import 'package:firebase_auth/firebase_auth.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/services/services.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // Auth user stream
  Stream<AppUser?> get appUserStream {
    return _auth.authStateChanges().map((User? user) => _appUserFromFirebaseUser(user));
  }

  // Register with email

  static Future registerWithEmailAndPassword(String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    // Create user record in database
    UserDatabase.createUserRecord(_appUserFromFirebaseUser(_auth.currentUser)!);
  }

  // Register gmail

  // Register with facebook

  // Sign out
  static Future signOut() async {
    await _auth.signOut();
  }

  // AppUser from Firebase user
  static AppUser? _appUserFromFirebaseUser(User? user) {
    return (user != null) ? AppUser(uid: user.uid) : null;
  }
}
