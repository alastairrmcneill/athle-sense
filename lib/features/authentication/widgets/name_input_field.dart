// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class NameInputField extends StatelessWidget {
  final TextEditingController textEditingController;
  const NameInputField({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.headline5,
      decoration: const InputDecoration(
        labelText: 'Name',
        prefixIcon: Icon(Icons.person_outline),
      ),
      maxLines: 1,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
      },
      onSaved: (value) {
        textEditingController.text = value!;
      },
    );
  }
}
