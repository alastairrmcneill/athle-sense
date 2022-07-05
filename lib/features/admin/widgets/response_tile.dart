import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/screens/screens.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class ResponseTile extends StatefulWidget {
  final Member member;
  final Response? response;
  const ResponseTile({Key? key, required this.member, required this.response}) : super(key: key);

  @override
  State<ResponseTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<ResponseTile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return GestureDetector(
      onTap: () {
        // Set notifier
        if (widget.response != null) {
          List<Response> _allResponsesForMember = [];

          responseNotifier.allResponses!.forEach((response) {
            if (widget.member.uid == response.userUid) {
              _allResponsesForMember.add(response);
            }
          });

          responseNotifier.setCurrentResponse = widget.response!;
          responseNotifier.setAllResponsesForMember = _allResponsesForMember;
          Navigator.push(context, MaterialPageRoute(builder: (_) => const MemberDetailScreen()));
        }
      },
      child: Container(
        height: 50,
        color: widget.response == null ? Colors.red : Colors.green,
        child: Column(
          children: [
            Text(widget.member.name),
            widget.response == null ? Text('Not responded') : Text('Responded'),
          ],
        ),
      ),
    );
  }
}
