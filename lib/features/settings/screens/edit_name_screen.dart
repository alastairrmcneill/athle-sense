import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/auth_service.dart';
import 'package:wellness_tracker/services/user_database.dart';

class EditNameScreen extends StatefulWidget {
  const EditNameScreen({super.key});

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();
}

class _EditNameScreenState extends State<EditNameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
    textEditingController = TextEditingController(text: userNotifier.currentUser!.name);
  }

  Future _save() async {
    await AuthService.updateUserName(
      context,
      name: textEditingController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Name',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: textEditingController,
                  style: Theme.of(context).textTheme.headline5,
                  decoration: const InputDecoration(
                    hintText: 'Name',
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
                    await _save();
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
