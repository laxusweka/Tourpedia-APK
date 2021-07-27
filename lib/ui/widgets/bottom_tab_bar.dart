import 'package:flutter/material.dart';
import 'package:tourpedia/ui/pages/culinary.dart';
import 'package:tourpedia/ui/pages/favorite.dart';
import 'package:tourpedia/ui/pages/profile.dart';
import 'package:tourpedia/ui/pages/tourism.dart';
import 'package:tourpedia/utils/my_colors.dart';

class BottomTabBar extends StatefulWidget {
  const BottomTabBar({Key? key}) : super(key: key);

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in TabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: MyColors.white,
        selectedItemColor: MyColors.blueThird,
        unselectedItemColor: MyColors.black,
        elevation: 3,
        onTap: (int index) => setState(
          () => _currentIndex = index,
        ),
        items: [
          for (final tabItem in TabNavigationItem.items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              label: tabItem.title,
            ),
        ],
      ),
    );
  }
}

class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem(
      {required this.page, required this.title, required this.icon});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: const Tourism(),
          title: 'Tourism',
          icon: const Icon(Icons.explore_outlined),
        ),
        TabNavigationItem(
          page: const Culinary(),
          title: 'Culinary',
          icon: const Icon(Icons.restaurant_outlined),
        ),
        TabNavigationItem(
          page: const Favorite(),
          title: 'Favorite',
          icon: const Icon(Icons.favorite_outline),
        ),
        TabNavigationItem(
          page: const Profile(),
          title: 'Profile',
          icon: const Icon(Icons.account_circle_outlined),
        ),
      ];
}
