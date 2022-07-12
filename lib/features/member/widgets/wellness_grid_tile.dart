import 'package:flutter/material.dart';
import 'package:reading_wucc/support/theme.dart';

class WellnessGridTile extends StatelessWidget {
  final String title;
  final String value;
  final int baselineCompare;
  final int previousCompare;

  const WellnessGridTile({
    Key? key,
    required this.title,
    required this.value,
    required this.baselineCompare,
    required this.previousCompare,
  }) : super(key: key);

  Widget _buildCompare(BuildContext context, String baseString, int compare) {
    String _string = '';
    Color? _color = MyColors.darkTextColor;

    if (compare > 0) {
      _string = '$baseString\n+$compare';
      _color = MyColors.darkGreenColor;
    } else if (compare == 0) {
      _string = '$baseString\n-';
    } else if (compare < 0) {
      _string = '$baseString\n$compare';
      _color = MyColors.darkRedColor;
    }

    return Text(
      _string,
      style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 10, color: _color),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(color: MyColors.lightBlueColor, borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Center(
            child: Text(
              value,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCompare(context, 'Baseline', baselineCompare),
                  _buildCompare(context, 'Yesterday', previousCompare),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
