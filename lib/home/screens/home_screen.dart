import 'package:flutter/material.dart';
import 'package:reading_wucc/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: ElevatedButton(
          onPressed: () async {
            AuthService.signOut();
          },
          child: Text('Sign out')),
    );
  }
}
