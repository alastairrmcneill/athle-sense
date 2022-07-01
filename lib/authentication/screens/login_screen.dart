import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/authentication/screens/screens.dart';
import 'package:reading_wucc/authentication/widgets/error_text_widget.dart';
import 'package:reading_wucc/models/custom_error.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/services/services.dart';
import 'package:reading_wucc/support/wrapper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _errorText = '';

  Future _login(UserNotifier userNotifier) async {
    dynamic result = await AuthService.signInWithEmailPassword(
      userNotifier,
      _email.trim(),
      _password.trim(),
    );

    // Check result, if error exit, if good push back to wrapper
    if (result is CustomError) {
      setState(() {
        _errorText = result.message;
      });
      return;
    }
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Wrapper()), (_) => false);
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
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
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
          ErrorText(errorText: _errorText),
          ElevatedButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return;
              }
              _formKey.currentState!.save();
              await _login(userNotifier);
            },
            child: Text('Login'),
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPassword())),
                  child: const Text('Forgot Password'),
                ),
                const VerticalDivider(
                  indent: 10,
                  endIndent: 10,
                ),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                  child: Text('Sign Up'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
