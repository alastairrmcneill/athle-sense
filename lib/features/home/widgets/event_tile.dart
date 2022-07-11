import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/screens/screens.dart';
import 'package:reading_wucc/features/member/screens/screens.dart';
import 'package:reading_wucc/models/models.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class EventTile extends StatelessWidget {
  final Event event;
  const EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context);
    return GestureDetector(
      onTap: () {
        eventNotifier.setCurrentEvent = event;
        Navigator.push(context, MaterialPageRoute(builder: (_) => event.amAdmin ? const EventDetailAdmin() : const EventDetailMember()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: event.amAdmin ? Colors.red : Colors.blue,
                gradient: const LinearGradient(
                  colors: [Color(0xFFEFFDDD), Color(0xFFBCE9F1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
            height: 300,
            child: AutoSizeText(
              event.name,
              maxLines: 2,
              wrapWords: true,
              minFontSize: 16,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 60),
            ),
          ),
        ),
      ),
    );
  }
}
