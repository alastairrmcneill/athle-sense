import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/authentication/widgets/email_input_field.dart';
import 'package:wellness_tracker/services/auth_service.dart';
import 'package:wellness_tracker/features/authentication/widgets/error_text_widget.dart';
import 'package:wellness_tracker/models/models.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextEditingController = TextEditingController();
  String _errorText = '';

  Future _forgotPassword() async {
    await AuthService.forgotPassword(
      context,
      email: _emailTextEditingController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Recovery'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
                child: Text(
                  'To reset your password, please enter your email address below.',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    EmailInputField(textEditingController: _emailTextEditingController),
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
                    await _forgotPassword();
                  },
                  child: Text('Send email'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
