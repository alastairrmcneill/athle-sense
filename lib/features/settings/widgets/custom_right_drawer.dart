import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/settings/widgets/widgets.dart';
import 'package:wellness_tracker/services/services.dart';

class CustomRightDrawer extends StatelessWidget {
  const CustomRightDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await AuthService.signOut();
                  },
                  child: const Text('Sign Out'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () async {
                      await showDeleteAccountDialog(context: context);
                    },
                    child: const Text('Delete Account')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
