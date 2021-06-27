import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/page/PageHome.dart';
import 'package:todo/state/ProjectState.dart';
import 'package:todo/state/TodoState.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TodoState()),
        ChangeNotifierProvider(create: (context) => ProjectState()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo App",
      home: PageHome(),
    );
  }
}
