import 'package:flutter/material.dart';
import 'package:reading_wucc/models/models.dart';

class MemberTile extends StatefulWidget {
  final Member member;
  final Response? response;
  const MemberTile({Key? key, required this.member, required this.response}) : super(key: key);

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: widget.response == null ? Colors.red : Colors.green,
      child: Column(
        children: [
          Text(widget.member.name),
          widget.response == null ? Text('Not responded') : Text('Responded'),
        ],
      ),
    );
  }
}
