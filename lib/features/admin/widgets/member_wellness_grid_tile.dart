import 'package:flutter/material.dart';

class MemberWellnessGridTile extends StatelessWidget {
  final String title;
  final String value;

  const MemberWellnessGridTile({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(children: [
        Text(title),
        Text(value),
      ]),
    );
  }
}
