import 'package:flutter/material.dart';
import 'package:markdown_note/model/Note.dart';
import 'package:markdown_note/store/NoteStore.dart';

import 'PageEditor.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  List<Note> noteListData = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      noteListData = NoteStore.notes(context);
    });
  }

  Widget getDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("分类列表", style: TextStyle(fontSize: 24)),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text("分类1"),
          ),
          ListTile(
            title: Text("分类2"),
          ),
          ListTile(
            title: Text("分类3"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Markdown 笔记"),
      ),
      drawer: getDrawer(),
      body: Center(
        child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              Note note = noteListData[index];

              return ListTile(
                isThreeLine: true,
                title: Text(note.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(note.category),
                    Text(note.content,
                        overflow: TextOverflow.ellipsis, maxLines: 1)
                  ],
                ),
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PageEditor(note)))
                },
              );
            },
            itemCount: noteListData.length),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => PageEditor(null))),
        child: Icon(Icons.add),
      ),
    );
  }
}
