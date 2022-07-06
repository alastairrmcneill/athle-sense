import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/models/response.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class MemberWellnessGridView extends StatelessWidget {
  const MemberWellnessGridView({Key? key}) : super(key: key);

  List<Widget> _buildTiles(ResponseNotifier responseNotifier) {
    Response currentResponse = responseNotifier.currentResponse!;
    Response firstResponse = responseNotifier.allResponsesForMember![0];

    List<Widget> _tiles = [];
    _tiles.add(MemberWellnessGridTile(
      title: 'Wellness',
      value: currentResponse.wellnessRating.toString(),
      baselineCompare: currentResponse.wellnessRating - firstResponse.wellnessRating,
    ));

    for (var i = 1; i <= currentResponse.ratings.length; i++) {
      _tiles.add(MemberWellnessGridTile(
        title: 'Q${i}',
        value: currentResponse.ratings[i - 1].toString(),
        baselineCompare: currentResponse.ratings[i - 1] - firstResponse.ratings[i - 1],
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
