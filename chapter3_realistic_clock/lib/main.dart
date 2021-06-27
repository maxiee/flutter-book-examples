import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realisticclock/components/ClockHand.dart';
import 'package:realisticclock/components/ClockHandSecond.dart';
import 'package:realisticclock/components/ClockPanel.dart';

import 'components/ClockCenter.dart';
import 'components/ClockHandSecond2.dart';
import 'components/ClockPanel2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  DateTime now = DateTime.now();
  Timer timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          now = DateTime.now();
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final clockSize = Size(screenWidth * 0.9, screenWidth * 0.9);

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ClockPanel(clockSize),
            ClockHand(clockSize, ClockHandType.minute,
                now.hour, now.minute, now.second),
            ClockHand(clockSize, ClockHandType.hour,
                now.hour, now.minute, now.second),
            ClockHandSecond(clockSize, now.second),
            ClockCenter()
//            ClockCenterCircle(clockSize)
          ],
        ),
      ),
    );
  }
}