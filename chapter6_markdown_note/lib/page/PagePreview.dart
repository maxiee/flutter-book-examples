import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PagePreview extends StatelessWidget {
  final String title;
  final String markdown;

  PagePreview(this.title, this.markdown);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Markdown(
          data: markdown,
        ),
      ),
    );
  }
}