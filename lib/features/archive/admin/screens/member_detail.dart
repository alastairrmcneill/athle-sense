import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/archive/admin/widgets/widgets.dart';
import 'package:wellness_tracker/models/models.dart';

class MemberDetailScreen extends StatefulWidget {
  final Member member;
  const MemberDetailScreen({Key? key, required this.member}) : super(key: key);

  @override
  State<MemberDetailScreen> createState() => _MemberDetailScreenState();
}

class _MemberDetailScreenState extends State<MemberDetailScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.member.name),
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
