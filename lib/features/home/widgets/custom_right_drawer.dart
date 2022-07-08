import 'package:flutter/material.dart';
import 'package:reading_wucc/services/auth_service.dart';
import 'package:reading_wucc/services/user_database.dart';

class CustomRightDrawer extends StatelessWidget {
  const CustomRightDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Container(
              height: 100,
              color: Colors.red,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          TextButton(
            onPressed: () async {
              await AuthService.signOut();
            },
            child: Text('Sign Out'),
          ),
          TextButton(
              onPressed: () async {
                await AuthService.delete();
              },
              child: Text('Delete')),
        ],
      ),
    );
  }
}
