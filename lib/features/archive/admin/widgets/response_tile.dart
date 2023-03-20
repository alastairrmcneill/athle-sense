import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/archive/admin/screens/screens.dart';
import 'package:wellness_tracker/models/models.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';
import 'package:wellness_tracker/support/theme.dart';

class ResponseTile extends StatefulWidget {
  final Member member;
  final Response? response;
  const ResponseTile({Key? key, required this.member, required this.response}) : super(key: key);

  @override
  State<ResponseTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<ResponseTile> {
  Color _backgroundColor = MyColors.lightBlueColor!;
  Color _foregroundColor = MyColors.darkBlueColor!;
  @override
  void initState() {
    super.initState();
    if (widget.response == null) {
      return;
    }
    if (widget.response!.availability == 1) {
      _backgroundColor = MyColors.lightRedColor!;
      _foregroundColor = MyColors.darkRedColor!;
    } else if (widget.response!.availability == 2) {
      _backgroundColor = MyColors.lightYellowColor!;
      _foregroundColor = MyColors.darkYellowColor!;
    } else if (widget.response!.availability == 3) {
      _backgroundColor = MyColors.lightGreenColor!;
      _foregroundColor = MyColors.darkGreenColor!;
    } else {
      _backgroundColor = MyColors.lightBlueColor!;
      _foregroundColor = MyColors.darkBlueColor!;
    }
  }

  Widget _buildIcon() {
    if (widget.response == null) {
      return Icon(
        Icons.block,
        color: _foregroundColor,
      );
    } else {
      return Response.availabilityIcons[widget.response!.availability - 1];
    }
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return GestureDetector(
      onTap: () {
        // Set notifier
        if (widget.response != null) {
          List<Response> _allResponsesForMember = [];
          print(responseNotifier.allResponses!);
          print('');
          responseNotifier.allResponses!.forEach((response) {
            if (widget.member.uid == response.userUid) {
              _allResponsesForMember.add(response);
            }
          });

          responseNotifier.setCurrentResponse = widget.response!;
          responseNotifier.setAllResponsesForMember = _allResponsesForMember;
          Navigator.push(context, MaterialPageRoute(builder: (_) => MemberDetailScreen(member: widget.member)));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 20),
            height: 70,
            decoration: BoxDecoration(
              color: widget.response == null ? MyColors.lightBlueColor : _backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.member.name,
                  style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 30, color: _foregroundColor),
                ),
                _buildIcon(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
