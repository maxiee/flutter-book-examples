import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tech_news/net/GitHub.dart';
import 'package:tech_news/net/GitHubServices.dart';
//import 'package:tech_news/page/test.dart';
import 'package:tech_news/page/PageHomeFeed.dart';


void main() {
  final github = GitHub("3743ecb6de3113385591fee740365b2e25ac6410");
  GitHubServices.init(github);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '技术头条',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PageHomeFeed(),
    );
  }
}

