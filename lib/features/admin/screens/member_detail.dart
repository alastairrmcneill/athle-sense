import 'package:flutter/material.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';

class MemberDetailScreen extends StatefulWidget {
  const MemberDetailScreen({Key? key}) : super(key: key);

  @override
  State<MemberDetailScreen> createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Member Detail'),
      ),
      body: Column(
        children: const [
          MemberWellnessGraphs(),
          MemberAvailability(),
          Expanded(flex: 1, child: MemberWellnessGridView()),
        ],
      ),
    );
  }
}
