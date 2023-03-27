import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/authentication/widgets/widgets.dart';
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

  Future _register(UserNotifier userNotifier) async {
    // Check passwords match, if not exit
    if (_password1TextEditingController.text != _password2TextEditingController.text) {
      setState(() {
        _errorText = 'Passwords must match';
      });
      return;
    }

    // Create app user and log in firebase
    AppUser newAppUser = AppUser(
      name: _nameTextEditingController.text.trim(),
    );
    dynamic result = await AuthService.registerWithEmailAndPassword(
      userNotifier,
      newAppUser,
      _emailTextEditingController.text.trim(),
      _password1TextEditingController.text.trim(),
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

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
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
                    PasswordInputField(textEditingController: _password1TextEditingController, confirmPassword: false),
                    PasswordInputField(textEditingController: _password2TextEditingController, confirmPassword: true),
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
                      await _register(userNotifier);
                    },
                    child: Text('Register')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
