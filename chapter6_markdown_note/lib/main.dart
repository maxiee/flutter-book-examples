import 'package:flutter/material.dart';
import 'package:markdown_note/page/PageHome.dart';
import 'package:markdown_note/store/NoteStore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoteStore(
        MaterialApp(
          title: 'Markdown Editor',
          home: PageHome(),
        )
    );
  }
}
