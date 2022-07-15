import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/features/member/widgets/widgets.dart';
import 'package:reading_wucc/models/question.dart';
import 'package:reading_wucc/models/response.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class MemberWellnessGridView extends StatelessWidget {
  const MemberWellnessGridView({Key? key}) : super(key: key);

  List<Widget> _buildTiles(ResponseNotifier responseNotifier) {
    Response currentResponse = responseNotifier.currentResponse!;
    Response firstResponse = responseNotifier.allResponsesForMember![0];
    int index = 0;
    for (var i = 0; i < responseNotifier.allResponsesForMember!.length; i++) {
      if (currentResponse.uid == responseNotifier.allResponsesForMember![i].uid) {
        index = i;
      }
    }

    Response? previousResponse = responseNotifier.allResponsesForMember![0];
    if (index > 0) {
      previousResponse = responseNotifier.allResponsesForMember![index - 1];
    }

    List<Widget> _tiles = [];
    _tiles.add(WellnessGridTile(
      title: 'Wellness',
      value: currentResponse.wellnessRating.toString(),
      baselineCompare: currentResponse.wellnessRating - firstResponse.wellnessRating,
      previousCompare: currentResponse.wellnessRating - previousResponse.wellnessRating,
    ));

    for (var i = 0; i < currentResponse.ratings.length; i++) {
      _tiles.add(WellnessGridTile(
        title: myQuestions[i].short,
        value: currentResponse.ratings[i].toString(),
        baselineCompare: currentResponse.ratings[i] - firstResponse.ratings[i],
        previousCompare: currentResponse.ratings[i] - previousResponse.ratings[i],
      ));
    }

    return _tiles;
  }

  @override
  Widget build(BuildContext context) {
    ResponseNotifier responseNotifier = Provider.of<ResponseNotifier>(context);

    return GridView.count(
      crossAxisCount: 2,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 30),
      crossAxisSpacing: 30,
      mainAxisSpacing: 30,
      childAspectRatio: 1.5,
      children: _buildTiles(responseNotifier),
    );
  }
}
