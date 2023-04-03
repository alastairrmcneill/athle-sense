import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/paywall/screens/screens.dart';
import 'package:wellness_tracker/features/settings/screens/screens.dart';
import 'package:wellness_tracker/features/settings/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/services/services.dart';
import 'package:wellness_tracker/support/theme.dart';

class CustomRightDrawer extends StatelessWidget {
  const CustomRightDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RevenueCatNotifier revenueCatNotifier = Provider.of<RevenueCatNotifier>(context);
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Account Details',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        color: MyColors.lightTextColor!.withOpacity(0.8),
                      ),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountDetailsScreen())),
                    ),
                    Divider(
                      color: MyColors.lightTextColor!.withOpacity(0.8),
                    ),
                    ListTile(
                      title: Text(
                        'Theme',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        color: MyColors.lightTextColor!.withOpacity(0.8),
                      ),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ChangeThemeScreen())),
                    ),
                    Divider(
                      color: MyColors.lightTextColor!.withOpacity(0.8),
                    ),
                    ListTile(
                      title: Text(
                        'Notifications',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        color: MyColors.lightTextColor!.withOpacity(0.8),
                      ),
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationSettingsScreen())),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await AuthService.signOut(context);
                  },
                  child: Text('Sign out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
