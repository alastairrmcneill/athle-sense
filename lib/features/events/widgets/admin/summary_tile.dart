// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../support/theme.dart';

class SummaryTile extends StatelessWidget {
  final String title;
  final String content;
  final Function onTap;
  const SummaryTile({
    Key? key,
    required this.title,
    required this.content,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.2,
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
                child: Text(
                  content,
                  style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 30),
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
