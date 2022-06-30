import 'package:flutter/material.dart';
import 'package:reading_wucc/services/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  Future login() async {}

  Widget _buildNameInput() {
    return TextFormField();
  }

  Widget _buildEmailInput() {
    return TextFormField();
  }

  Widget _buildPasswordInput() {
    return TextFormField();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildEmailInput(),
              _buildPasswordInput(),
            ],
          ),
        ),
        ElevatedButton(onPressed: () {}, child: Text('Login'))
      ]),
    );
  }
}
