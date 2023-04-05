import 'package:flutter/material.dart';
import 'package:wellness_tracker/support/theme.dart';

class CustomToggleButton extends StatelessWidget {
  final bool selected;
  final String text;
  const CustomToggleButton({Key? key, required this.selected, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          color: selected ? MyColors.darkBackgroundColor : MyColors.darkCardColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6!,
          ),
        ),
      ),
    );
  }
}
