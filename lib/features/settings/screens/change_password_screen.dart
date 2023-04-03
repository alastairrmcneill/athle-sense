import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/authentication/widgets/widgets.dart';
import 'package:wellness_tracker/features/home/widgets/widgets.dart';
import 'package:wellness_tracker/services/auth_service.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController1 = TextEditingController();
  TextEditingController _newPasswordController2 = TextEditingController();

  Future _changePassword(BuildContext context) async {
    bool currentPasswordValid = await AuthService.validatePassword(
      context,
      password: _currentPasswordController.text.trim(),
    );

    if (!currentPasswordValid) return;

    if (_newPasswordController1.text.trim() != _newPasswordController2.text.trim()) {
      showErrorDialog(context, 'New passwords must match');
      return;
    }

    await AuthService.changePassword(
      context,
      newPassword: _newPasswordController1.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Change Password',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    PasswordInputField(
                      textEditingController: _currentPasswordController,
                      labelText: 'Current Password',
                    ),
                    PasswordInputField(
                      textEditingController: _newPasswordController1,
                      labelText: 'New Password',
                    ),
                    PasswordInputField(
                      textEditingController: _newPasswordController2,
                      labelText: 'Confirm New Password',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    _formKey.currentState!.save();
                    await _changePassword(context);
                  },
                  child: Text('Change Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
