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

  Widget _buildEmailInput() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email'),
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
        int atIndex = value.indexOf('@');
        int periodIndex = value.lastIndexOf('.');
        if (!value.contains('@') || atIndex < 1 || periodIndex <= atIndex + 1 || value.length == periodIndex + 1) {
          return 'Not a valid email';
        }
      },
      onSaved: (value) {
        _email = value!;
      },
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Password'),
      maxLines: 1,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
        if (value.length < 5) {
          return 'Password needs to be greater than 6 characters';
        }
      },
      onSaved: (value) {
        _password = value!;
      },
    );
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
        ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              print('Login');
            },
            child: Text('Login'))
      ]),
    );
  }
}
