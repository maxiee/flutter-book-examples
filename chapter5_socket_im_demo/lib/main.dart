import 'package:flutter/material.dart';
import 'package:socket_im_demo/model/Message.dart';
import 'package:socket_im_demo/net/Socket.dart';
import 'package:socket_im_demo/page/ChatPage.dart';
import 'package:socket_im_demo/page/SettingHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  BaseSocketCS _socketCS;

  List<Message> _messages = [];

  void createServer(int port) {
    setState(() {
      _socketCS = SocketServer(port);
    });
    initSocketCS();
  }

  void createClient(String address, int port) {
    setState(() {
      _socketCS = SocketClient(address, port);
    });
    initSocketCS();
  }

  void initSocketCS() {
    _socketCS.init();
    _socketCS.msgStream.stream.listen((msg) {
      debugPrint(msg.toJson().toString());
      setState(() {
        _messages.insert(0, msg);
      });
    });
  }

  void onSendMessage(String msgText, String meme) {
    var msgToUser = Message(Message.TYPE_USER, msgText, meme);
    var msgToMe = Message(Message.TYPE_ME, msgText, meme);
    _socketCS.send(msgToUser);
    setState(() {
      _messages.insert(0, msgToMe);
    });
  }

  void goToChatPage(BuildContext childContext) {
    Navigator.of(childContext).pushReplacement(
        MaterialPageRoute(builder:
            (context) => ChatPage(_messages, onSendMessage)));
  }

  @override
  void dispose() {
    super.dispose();
    _socketCS?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Socket IM',
      home: SettingHomePage(
          this.createServer,
          this.createClient,
          this.goToChatPage),
    );
  }
}


