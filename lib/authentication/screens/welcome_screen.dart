import 'package:flutter/material.dart';
import 'package:reading_wucc/authentication/screens/login_screen.dart';
import 'package:reading_wucc/authentication/screens/register_screen.dart';
import 'package:reading_wucc/authentication/services/auth_service.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Welcome'),
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed: (() => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()))), child: Text('Login')),
            ElevatedButton(onPressed: (() => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()))), child: Text('Register')),
          ],
        ));
  }
}
