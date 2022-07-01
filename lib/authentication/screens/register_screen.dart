import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;
  late String _password1;
  late String _password2;

  Widget _buildNameInput() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Name'),
      maxLines: 1,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
      },
      onSaved: (value) {
        _name = value!;
      },
    );
  }

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

  Widget _buildPassword1Input() {
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
        _password1 = value!;
      },
    );
  }

  Widget _buildPassword2Input() {
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
        _password2 = value!;
      },
    );
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
              _buildPassword1Input(),
              _buildPassword2Input(),
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              print('Register');
            },
            child: Text('Register'))
      ]),
    );
  }
}
