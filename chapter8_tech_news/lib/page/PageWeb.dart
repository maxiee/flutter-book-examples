import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PageWeb extends StatelessWidget {
  final String _url;

  PageWeb(this._url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: _url,
        ),
      ),
    );
  }
}