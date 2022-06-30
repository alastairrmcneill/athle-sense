import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        title: Text('Register'),
      ),
      body: Column(children: [
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildNameInput(),
              _buildEmailInput(),
              _buildPasswordInput(),
              _buildPasswordInput(),
            ],
          ),
        ),
        ElevatedButton(onPressed: () {}, child: Text('Register'))
      ]),
    );
  }
}
