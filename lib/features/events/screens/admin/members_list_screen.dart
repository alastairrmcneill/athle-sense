import 'package:flutter/material.dart';
import 'package:wellness_tracker/features/events/widgets/widgets.dart';

class MembersListScreen extends StatelessWidget {
  const MembersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member'),
        centerTitle: false,
      ),
      body: const MembersTab(),
    );
  }
}
