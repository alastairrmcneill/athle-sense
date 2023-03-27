// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class EmailInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  const EmailInputField({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      style: Theme.of(context).textTheme.headline5,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email_outlined),
      ),
      maxLines: 1,
      autocorrect: false,
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
        textEditingController.text = value!;
      },
    );
  }
}
