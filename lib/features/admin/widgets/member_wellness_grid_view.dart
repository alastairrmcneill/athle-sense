import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/models/question.dart';
import 'package:reading_wucc/models/response.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class MemberWellnessGridView extends StatelessWidget {
  const MemberWellnessGridView({Key? key}) : super(key: key);

  List<Widget> _buildTiles(ResponseNotifier responseNotifier) {
    Response currentResponse = responseNotifier.currentResponse!;
    Response firstResponse = responseNotifier.allResponsesForMember![0];
    int index = responseNotifier.allResponsesForMember!.indexOf(currentResponse);
    Response? previousResponse = responseNotifier.allResponsesForMember![0];
    if (index != 0) {
      previousResponse = responseNotifier.allResponsesForMember![index - 1];
    }

    List<Widget> _tiles = [];
    _tiles.add(MemberWellnessGridTile(
      title: 'Wellness',
      value: currentResponse.wellnessRating.toString(),
      baselineCompare: currentResponse.wellnessRating - firstResponse.wellnessRating,
      previousCompare: currentResponse.wellnessRating - previousResponse.wellnessRating,
    ));

    for (var i = 0; i < currentResponse.ratings.length; i++) {
      _tiles.add(MemberWellnessGridTile(
        title: Questions.short[i],
        value: currentResponse.ratings[i].toString(),
        baselineCompare: currentResponse.ratings[i] - firstResponse.ratings[i],
        previousCompare: currentResponse.ratings[i] - previousResponse.ratings[0],
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
