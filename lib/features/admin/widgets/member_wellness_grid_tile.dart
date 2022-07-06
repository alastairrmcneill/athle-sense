import 'package:flutter/material.dart';

class MemberWellnessGridTile extends StatelessWidget {
  final String title;
  final String value;
  final int baselineCompare;

  const MemberWellnessGridTile({Key? key, required this.title, required this.value, required this.baselineCompare}) : super(key: key);

  String _buildCompare() {
    if (baselineCompare > 0) {
      return '+${baselineCompare}';
    }
    return '$baselineCompare';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(children: [
        Text(title),
        Text(value),
        Text(_buildCompare()),
      ]),
    );
  }
}
