import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/authentication/widgets/widgets.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';
import 'package:wellness_tracker/support/wrapper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _password1TextEditingController = TextEditingController();
  TextEditingController _password2TextEditingController = TextEditingController();

  String _errorText = '';

  Future _register() async {
    // Check passwords match, if not exit
    if (_password1TextEditingController.text != _password2TextEditingController.text) {
      showErrorDialog(context, 'Passowrds must match.');
      return;
    }

    // Create app user and log in firebase
    await AuthService.registerWithEmailAndPassword(
      context,
      name: _nameTextEditingController.text.trim(),
      email: _emailTextEditingController.text.trim(),
      password: _password1TextEditingController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NameInputField(textEditingController: _nameTextEditingController),
                    EmailInputField(textEditingController: _emailTextEditingController),
                    PasswordInputField(
                      textEditingController: _password1TextEditingController,
                      labelText: 'Password',
                    ),
                    PasswordInputField(
                      textEditingController: _password2TextEditingController,
                      labelText: 'Confirm Password',
                    ),
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
                      await _register();
                    },
                    child: Text('Register')),
              ),
              const SizedBox(height: 5),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "By creating an account, you are agreeing to our\n",
                  style: Theme.of(context).textTheme.headline6,
                  children: [
                    TextSpan(
                      text: "Terms & Conditions ",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showDocumentDialog(context, mdFileName: 'assets/terms_and_conditions.md');
                        },
                    ),
                    TextSpan(
                      text: "and ",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    TextSpan(
                      text: "Privacy Policy",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showDocumentDialog(context, mdFileName: 'assets/privacy_policy.md');
                        },
                    ),
                    TextSpan(
                      text: ".",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
