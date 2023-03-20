import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/archive/member/widgets/widgets.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class DailyResponseTab extends StatelessWidget {
  const DailyResponseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DailyResponseForm();
  }
}
