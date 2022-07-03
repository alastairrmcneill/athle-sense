import 'package:flutter/material.dart';
import 'package:reading_wucc/models/models.dart';

class MemberTile extends StatefulWidget {
  final Member member;
  const MemberTile({Key? key, required this.member}) : super(key: key);

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.green,
      child: Text(widget.member.name),
    );
  }
}
