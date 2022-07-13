import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';
import 'package:reading_wucc/support/theme.dart';

class MemberAvailability extends StatefulWidget {
  const MemberAvailability({Key? key}) : super(key: key);

  @override
  State<MemberAvailability> createState() => _MemberAvailabilityState();
}

class _MemberAvailabilityState extends State<MemberAvailability> {
  String availabilityString = 'Unknown';
  Color textColor = MyColors.darkTextColor!;
  Color backgroundColor = MyColors.lightBlueColor!;
  void _buildTextDetails(ResponseNotifier responseNotifier) {
    switch (responseNotifier.currentResponse!.availability) {
      case 1:
        {
          availabilityString = 'Out for the day';
          textColor = MyColors.darkRedColor!;
          backgroundColor = MyColors.lightRedColor!;
          return;
        }

      case 2:
        {
          availabilityString = 'Reduced pitch time';
          textColor = MyColors.darkYellowColor!;
          backgroundColor = MyColors.lightYellowColor!;
          return;
        }

      case 3:
        {
          availabilityString = 'Good to go!';
          textColor = MyColors.darkGreenColor!;
          backgroundColor = MyColors.lightGreenColor!;
          return;
        }

      default:
        {
          availabilityString = 'Unknown';
          return;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);
    _buildTextDetails(responseNotifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            availabilityString,
            style: Theme.of(context).textTheme.headline4!.copyWith(color: textColor, fontSize: 30),
          ),
        ),
      ),
    );
  }
}
