import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: 40,
          child: CupertinoTextField(
            prefix: Padding(
              padding: EdgeInsets.fromLTRB(9, 6, 9, 6),
              child: Icon(Icons.search, color: Colors.grey),
            ),
          ),
        ));
  }
}

class SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent) {
    return SearchBar();
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(
      covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
