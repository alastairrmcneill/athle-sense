import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reading_wucc/features/admin/widgets/widgets.dart';
import 'package:reading_wucc/models/response.dart';
import 'package:reading_wucc/notifiers/notifiers.dart';

class MemberWellnessGridView extends StatelessWidget {
  const MemberWellnessGridView({Key? key}) : super(key: key);

  List<Widget> _buildTiles(ResponseNotifier responseNotifier) {
    List<Widget> _tiles = [];
    _tiles.add(MemberWellnessGridTile(
      title: 'Wellness',
      value: responseNotifier.currentResponse!.wellnessRating.toString(),
    ));

    for (var i = 1; i <= responseNotifier.currentResponse!.ratings.length; i++) {
      _tiles.add(MemberWellnessGridTile(title: 'Q${i}', value: responseNotifier.currentResponse!.ratings[i - 1].toString()));
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
