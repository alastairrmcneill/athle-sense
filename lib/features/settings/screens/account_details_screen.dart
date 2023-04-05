import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/paywall/screens/screens.dart';
import 'package:wellness_tracker/features/settings/screens/screens.dart';
import 'package:wellness_tracker/features/settings/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RevenueCatNotifier revenueCatNotifier = Provider.of<RevenueCatNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account Details',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Name',
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Theme.of(context).textTheme.headline6!.color!.withOpacity(0.8),
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditNameScreen())),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              title: Text(
                'Change Password',
                style: Theme.of(context).textTheme.headline5,
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Theme.of(context).textTheme.headline6!.color!..withOpacity(0.8),
              ),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChangePasswordScreen())),
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            ListTile(
              title: Text(
                'Current Subscription',
                style: Theme.of(context).textTheme.headline5,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  revenueCatNotifier.proAccess ? "Pro" : "Basic",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Theme.of(context).textTheme.headline6!.color!.withOpacity(0.8),
              ),
              onTap: () {
                if (!revenueCatNotifier.proAccess) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
                }
              },
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
            ),
            !revenueCatNotifier.proAccess
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!revenueCatNotifier.proAccess) {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const PaywallScreen()));
                          }
                        },
                        child: Text('Get Pro'),
                      ),
                    ),
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    showDeleteAccountDialog(context: context);
                  },
                  child: const Text(
                    'Delete account',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
