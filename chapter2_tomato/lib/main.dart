import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '番茄钟',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const DEFAULT_COUNT_DOWN = Duration.secondsPerMinute * 25;
  int countDown = 0;
  /* flutter2.0添加了Sound null safety空安全声明，目的是通过显式声明可能为null的变量，以减少不必要的麻烦。
  参考资料：https://proxify.io/articles/flutter-2-null-safety
  **/
  //Timer timer;
  // 使用方法是在类型声明后添加?以标识这个对象（变量）是可以为null的
  Timer? timer;

  void startCountDown() {
    // if (timer != null) timer.cancel();
    //  使用的时候，后面跟!标记
    if (timer != null) timer!.cancel();
    countDown = DEFAULT_COUNT_DOWN;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        countDown--;
      });
      debugPrint(countDown.toString());
      if (countDown == 0) {
        timer.cancel();
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Text("成功获得一个番茄，请注意休息！"),
          );
        });
      }
    });
  }

  String padDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  String parseText() {
    return '${padDigits(countDown~/60)}:${padDigits(countDown%60)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          parseText(),
          style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.blue),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: startCountDown,
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
