import 'package:flutter/material.dart';
import 'package:socket_im_demo/components/MessageComponent.dart';
import 'package:socket_im_demo/model/Message.dart';

class ChatPage extends StatefulWidget {
  final List<Message> _messages;

  final Function(String msgText, String meme) _sendMsg;

  ChatPage(this._messages, this._sendMsg);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _msgController;

  bool memeShown = false;

  @override
  void initState() {
    super.initState();
    _msgController = TextEditingController();
  }

  @override
  void dispose() {
    _msgController.dispose();
  }

  Widget createMemeIcon(String imageRes) {
    return GestureDetector(
      onTap: () {
        widget._sendMsg("", imageRes);
      },
      child: Image.asset(imageRes, width: 100, height: 100,),
    );
  }

  Widget getMemeComponent() {
    return Container(
      height: 200,
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 16,
          runSpacing: 4,
          children: <Widget>[
            createMemeIcon("images/001.jpg"),
            createMemeIcon("images/002.jpg"),
            createMemeIcon("images/003.jpg"),
            createMemeIcon("images/004.jpg"),
          ],
        ),
      ),
    );
  }

  Widget getInputPanel() {
    return Container(
      padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  autofocus: true,
                  controller: _msgController,
                ),
              ),
              IconButton(
                icon: Icon(Icons.face),
                iconSize: 32,
                color: Colors.grey[600],
                onPressed: () =>
                    setState(() => memeShown = !memeShown),
              ),
              SizedBox(
                width: 12,
                height: 0
              ),
              IconButton(
                icon: Icon(Icons.send),
                iconSize: 32,
                color: Colors.grey[600],
                onPressed: () {
                  widget._sendMsg(_msgController.text, "");
                  _msgController.clear();
                },
              )
            ],
          ),
          if (memeShown) getMemeComponent()
        ],
      ),
    );
  }

  Widget getListView() {
    return ListView.builder(
      reverse: true,
      itemBuilder: (_, int index) {
        Message msg = widget._messages[index];
        return MessageComponent(msg);
      },
      itemCount: widget._messages.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: getListView(),
              ),
            ),
            getInputPanel()
          ],
        ),
      ),
    );
  }
}
