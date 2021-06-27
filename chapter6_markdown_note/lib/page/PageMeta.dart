import 'package:flutter/material.dart';

class PageMeta extends StatefulWidget {
  final String originTitle;
  final String originCategory;

  PageMeta(this.originTitle, this.originCategory);

  @override
  State<StatefulWidget> createState() {
    return _StatePageMeta();
  }
}

class _StatePageMeta extends State<PageMeta> {

  TextEditingController titleController;
  TextEditingController categoryController;

  @override
  void initState() {
    super.initState();
    titleController =
        TextEditingController(text: widget.originTitle);
    categoryController =
        TextEditingController(text: widget.originCategory);
  }

  void onSubmit() {
    Navigator.of(context).pop({
      'newTitle': titleController.text,
      'newCategory': categoryController.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("元信息"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check, color: Colors.white),
            onPressed: onSubmit,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("标题: "),
                Expanded(
                  child: TextField(
                    controller: titleController,
                  ),
                )
              ],
            ),
            SizedBox(width: 0, height: 20,),
            Row(
              children: <Widget>[
                Text("分类: "),
                Expanded(
                  child: TextField(
                    controller: categoryController,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}