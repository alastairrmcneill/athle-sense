import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wellness_tracker/features/archive/member/widgets/widgets.dart';
import 'package:wellness_tracker/models/question.dart';
import 'package:wellness_tracker/models/response.dart';
import 'package:wellness_tracker/notifiers/notifiers.dart';

class WellnessGridView extends StatelessWidget {
  final int day;
  const WellnessGridView({Key? key, required this.day}) : super(key: key);

  List<Widget> _buildTiles(ResponseNotifier responseNotifier) {
    Response currentResponse = responseNotifier.myResponses![day];
    Response firstResponse = responseNotifier.myResponses![0];
    int index = responseNotifier.myResponses!.indexOf(currentResponse);
    Response? previousResponse = responseNotifier.myResponses![0];
    if (index != 0) {
      previousResponse = responseNotifier.myResponses![index - 1];
    }

    List<Widget> _tiles = [];
    _tiles.add(ArchiveWellnessGridTile(
      title: 'Wellness',
      value: currentResponse.wellnessRating.toString(),
      baselineCompare: currentResponse.wellnessRating - firstResponse.wellnessRating,
      previousCompare: currentResponse.wellnessRating - previousResponse.wellnessRating,
    ));

    for (var i = 0; i < currentResponse.ratings.length; i++) {
      _tiles.add(ArchiveWellnessGridTile(
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
