import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class MemberAvailability extends StatelessWidget {
  const MemberAvailability({Key? key}) : super(key: key);

  String _buildText(ResponseNotifier responseNotifier) {
    switch (responseNotifier.currentResponse!.availability) {
      case 1:
        {
          return 'Out for the day';
        }

      case 2:
        {
          return 'Reduced pitch time';
        }

      case 3:
        {
          return 'Good to go!';
        }

      default:
        {
          return 'Unknown';
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return SizedBox(height: 50, child: Text(_buildText(responseNotifier)));
  }
}
