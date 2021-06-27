import 'package:flutter/material.dart';
import 'package:markdown_note/model/Note.dart';
import 'package:markdown_note/page/PagePreview.dart';
import 'package:markdown_note/store/NoteStore.dart';
import 'package:uuid/uuid.dart';

import 'PageMeta.dart';

class PageEditor extends StatefulWidget {
  final Note originNote;

  PageEditor(this.originNote);

  @override
  State<StatefulWidget> createState() {
    return _PageEditorState();
  }
}

class _PageEditorState extends State<PageEditor> {
  TextEditingController controller;

  String newTitle;
  String newCategory;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
        text: widget.originNote?.content ?? "");
    newTitle = widget.originNote?.title ?? "";
    newCategory = widget.originNote?.category ?? "待分类";
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void saveNote() async {
    NoteOperationRet result;
    if (widget.originNote == null) {
      String uuid = Uuid().v4();
      result = await NoteStore.createNewNote(
          context, Note(uuid, newTitle, newCategory, controller.text));
    } else {
      String uuid = widget.originNote.uuid;
      result = await NoteStore.updateExistedNote(
          context, uuid,
          Note(uuid, newTitle, newCategory, controller.text));
    }
    if (result != NoteOperationRet.SUCCESS) {
      // 后续可改为弹出对话框等用户可感知的提示形式
      print("笔记存储失败");
    } else {
      Navigator.of(context).pop();
    }
  }

  Widget getAppBar() {
    return AppBar(
      title: Row(
        children: <Widget>[
          Text(newTitle.isNotEmpty ? newTitle : "输入标题"),
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
            onPressed: () =>
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PageMeta(newTitle, newCategory)
            )).then((meta) {
              setState(() {
                // 返回不做处理
                if (meta == null) return;
                newTitle = meta['newTitle'];
                newCategory = meta['newCategory'];
              });
            }),
          )
        ],
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.movie,
            color: Colors.white,
          ),
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (buildContext) =>
                      PagePreview(newTitle, controller.text))),
        ),
        IconButton(
          icon: Icon(
            Icons.check,
            color: Colors.white,
          ),
          onPressed: saveNote,
        )
      ],
    );
  }

  /// 获取位置
  int _getEditorPosition() {
    return controller.selection.base.offset;
  }

  /// 向当前位置插入文本
  void input(String text, {deltaIndex = 0}) {
    int position = _getEditorPosition();

    String headString = controller.text.substring(0, position);
    String tailString = controller.text.substring(position);

    controller.value = TextEditingValue(
      text: headString + text + tailString,
      selection: TextSelection.collapsed(
          offset: position + text.length + deltaIndex)
    );
  }

  Widget createTextButton(String title, VoidCallback callback) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 14, 10, 14),
        child: Text(title),
      ),
      onTap: callback,
    );
  }

  Widget getToolbar() {
    return Column(
      children: <Widget>[
        Divider(height: 1, thickness: 1),
        Row(
          children: <Widget>[
            createTextButton('h1', () => input("# ")),
            createTextButton('h2', () => input("## ")),
            createTextButton('h3', () => input("### ")),
            IconButton(
              icon: Icon(
                  Icons.format_bold, color: Colors.grey),
              onPressed: () => input("****", deltaIndex: -2),
            ),
            IconButton(
              icon: Icon(
                  Icons.format_italic, color: Colors.grey),
              onPressed: () => input("**", deltaIndex: -1),
            ),
            IconButton(
              icon: Icon(
                  Icons.format_list_bulleted, color: Colors.grey),
              onPressed: () => input("* "),
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getAppBar(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: TextField(
                maxLines: null,
                minLines: 15,
                autofocus: true,
                controller: controller,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            getToolbar()
          ],
        ));
  }
}
