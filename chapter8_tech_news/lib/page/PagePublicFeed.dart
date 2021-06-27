import 'package:flutter/material.dart';
import 'package:tech_news/component/CardEvent.dart';
import 'package:tech_news/model/Activity.dart';
import 'package:tech_news/net/GitHubServices.dart';

class PagePublicFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StatePagePublicFeed();
  }
}

class _StatePagePublicFeed extends State<PagePublicFeed> {
  List<Event> _events = [];
  bool _loading = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() {
    print("拉取第${_currentPage}页");
    GitHubServices.activityService
        .listPublicEvents(_currentPage, 30)
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
      appBar: AppBar(
        title: Text("Public Events"),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _onScrollEvent,
        child: ListView.separated(
          itemBuilder: (context, index) {
            if (index == _events.length) {
              return Container(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  )
              );
            }
            return CardEvent(_events[index]);
          },
          itemCount: _events.length + 1,
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}