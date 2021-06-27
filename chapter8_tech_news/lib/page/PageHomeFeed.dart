import 'package:flutter/material.dart';
import 'package:tech_news/component/CardEvent.dart';
import 'package:tech_news/component/GridCategory.dart';
import 'package:tech_news/component/SearchBar.dart';
import 'package:tech_news/model/Activity.dart';
import 'dart:math' as math;

import 'package:tech_news/net/GitHubServices.dart';
import 'package:tech_news/page/PagePublicFeed.dart';

import 'PageTrending.dart';

class PageHomeFeed extends StatefulWidget {
  @override
  _PageHomeFeedState createState() => _PageHomeFeedState();
}

class _PageHomeFeedState extends State<PageHomeFeed> {
  List<Event> _events = [];
  bool _loading = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  List<Widget> createGrid() {
    List<GridItem> grids = [
      GridItem(
          "GitHub Trends",
          Icons.trending_up,
          Colors.orange,
              (context) => PageTrending()),
      GridItem(
          "Public Events",
          Icons.timeline_outlined,
          Colors.green,
              (context) => PagePublicFeed()),
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

  void loadNextPage() {
    print("拉取第${_currentPage}页");
    GitHubServices.activityService
        .listPersonalEvents("maxiee", _currentPage, 30)
        .then((value) => this.setState(() {
      print("第${_currentPage}页数据获取完成");
      _events.addAll(value);
      _currentPage++;
      _loading = false;
    }));
  }

  bool _onScrollEvent(ScrollNotification scrollNotification) {
    if (scrollNotification.metrics.extentAfter == 0.0 &&
        scrollNotification.metrics.pixels >=
            scrollNotification.metrics.maxScrollExtent * 0.8) {
      if (_loading) return false;

      setState(() {
        _loading = true;
      });

      loadNextPage();
    }
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
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2)),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final itemIndex = index ~/ 2;
                        if (index.isEven) {
                          return CardEvent(_events[itemIndex]);
                        }
                        return Divider();
                      },
                      childCount: math.max(0, _events.length * 2 - 1))),
              SliverToBoxAdapter(
                child: Container(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
