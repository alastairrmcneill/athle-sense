import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/authentication/screens/screens.dart';
import 'package:wellness_tracker/features/authentication/widgets/widgets.dart';
import 'package:wellness_tracker/models/custom_error.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController = TextEditingController();

  String _errorText = '';

  Future _login(UserNotifier userNotifier) async {
    dynamic result = await AuthService.signInWithEmailPassword(
      userNotifier,
      _emailTextEditingController.text.trim(),
      _passwordTextEditingController.text.trim(),
    );

    // Check result, if error exit, if good push back to wrapper
    if (result is CustomError) {
      setState(() {
        _errorText = result.message;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Wellness\nTracker',
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EmailInputField(textEditingController: _emailTextEditingController),
                    PasswordInputField(textEditingController: _passwordTextEditingController, confirmPassword: false),
                  ],
                ),
              ),
              ErrorText(errorText: _errorText),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    await _login(userNotifier);
                  },
                  child: Text('Login'),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPassword())),
                        child: const Text('Forgot Password'),
                      ),
                    ),
                    const VerticalDivider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                        child: Text('Sign Up'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
