import 'package:flutter/material.dart';
import 'package:tech_news/component/CardEvent.dart';
import 'package:tech_news/component/GridCategory.dart';
import 'package:tech_news/component/SearchBar.dart';
import 'package:tech_news/model/Activity.dart';
import 'dart:math' as math;

import 'package:tech_news/net/GitHubServices.dart';

import 'PageTrending.dart';

class PageHomeFeed extends StatefulWidget {
  @override
  _PageHomeFeedState createState() => _PageHomeFeedState();
}

class _PageHomeFeedState extends State<PageHomeFeed> {

  List<Widget> createGrid() {
    List<GridItem> grids = [
      GridItem(
          "GitHub Trends",
          Icons.trending_up,
          Colors.orange,
          (context) => null),
      GridItem(
          "Public Events",
          Icons.timeline_outlined,
          Colors.green,
          (context) => null),
      GridItem(
          "Users",
          Icons.people,
          Colors.pink,
          (context) => null),
      GridItem(
          "Projects",
          Icons.work, Colors.blue,
          (context) => null),
    ];
    return grids.map((e) => GridCategory(e)).toList();
  }

  bool _onScrollEvent(ScrollNotification scrollNotification) {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: _onScrollEvent,
          child: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: SearchBarDelegate(),
              ),
              SliverGrid(
                  delegate: SliverChildListDelegate(
                      createGrid()
                  ),
                  gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2)),
            ],
          ),
        ),
      ),
    );
  }
}
