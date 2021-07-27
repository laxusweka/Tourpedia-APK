import 'package:flutter/material.dart';
import 'package:tourpedia/ui/pages/favorite_tab_culinary.dart';
import 'package:tourpedia/ui/pages/favorite_tab_tourism.dart';
import 'package:tourpedia/utils/my_colors.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.bluePrimary,
              title: const Text('Favorite'),
              centerTitle: true,
              bottom: const TabBar(tabs: [
                Tab(text: 'Tourism'),
                Tab(text: 'Culinary'),
              ]),
            ),
            body: const TabBarView(
              children: [
                FavoriteTabTourism(),
                FavoriteTabCulinary(),
              ],
            )));
  }
}
