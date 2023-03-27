// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool confirmPassword;
  const PasswordInputField({
    Key? key,
    required this.textEditingController,
    required this.confirmPassword,
  }) : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.headline5,
      decoration: InputDecoration(
        labelText: !widget.confirmPassword ? 'Password' : 'Confirm Password',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: _obscureText ? const Icon(Icons.visibility_off_rounded) : const Icon(Icons.visibility_rounded),
        ),
      ),
      maxLines: 1,
      autocorrect: false,
      keyboardType: TextInputType.visiblePassword,
      obscureText: _obscureText,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
        if (value.length < 5) {
          return 'Password needs to be greater than 6 characters';
        }
      },
      onSaved: (value) {
        widget.textEditingController.text = value!;
      },
    );
  }
}
