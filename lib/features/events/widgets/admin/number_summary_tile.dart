// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:wellness_tracker/support/theme.dart';

class NumberSummaryTile extends StatelessWidget {
  final String title;
  final num number;
  final Function onTap;
  const NumberSummaryTile({
    Key? key,
    required this.title,
    required this.number,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.21,
        height: MediaQuery.of(context).size.width * 0.21,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.cardColor,
        ),
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    number == 0
                        ? const SizedBox()
                        : number > 0
                            ? Icon(
                                Icons.keyboard_double_arrow_up_rounded,
                                color: myCalendarColors[15],
                                size: MediaQuery.of(context).size.width * 0.08,
                              )
                            : Icon(
                                Icons.keyboard_double_arrow_down_rounded,
                                color: myCalendarColors[5],
                                size: MediaQuery.of(context).size.width * 0.08,
                              ),
                    AutoSizeText(
                      number == 0 ? '-' : number.abs().toStringAsFixed(1),
                      style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 24),
                      maxLines: 1,
                      maxFontSize: 24,
                      minFontSize: 12,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
