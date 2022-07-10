import 'package:flutter/material.dart';

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

  String _buildCompare(compare) {
    if (compare > 0) {
      return '+${compare}';
    } else if (compare == 0) {
      return '-';
    }
    return '$compare';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Column(children: [
        Text(title),
        Text(value),
        Text('To baseline: ${_buildCompare(baselineCompare)}'),
        Text('To yesterday: ${_buildCompare(previousCompare)}'),
      ]),
    );
  }
}
