import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/Project.dart';
import 'package:todo/state/ProjectState.dart';
import 'package:todo/utils/DateUtils.dart';

class PageProjectEdit extends StatefulWidget {
  final Project _project;

  PageProjectEdit(this._project);

  @override
  State<StatefulWidget> createState() {
    return _PageTodoEditState();
  }
}

class _PageTodoEditState extends State<PageProjectEdit> {
  TextEditingController _nameController;

  int _created;
  int _deadline;

  void saveProject() {
    ProjectState projectState = Provider.of<ProjectState>(
      context, listen: false);

    if (widget._project != null) {
      // update
      Project project = Project();
      project.id = widget._project.id;
      project.name = _nameController.text;
      project.created = _created;
      project.deadline = _deadline;
      projectState.updateProject(project);
    } else {
      // create
      Project project = Project();
      project.name = _nameController.text;
      project.created = _created;
      project.deadline = _deadline;
      projectState.createProject(project);
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    Project originProject = widget._project;

    _nameController = TextEditingController(
        text: originProject?.name ?? "");
    _created = originProject?.created
        ?? DateTime.now().millisecondsSinceEpoch;
    _deadline = originProject?.deadline ?? 0;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  Widget getNameRow() {
    return Row(
      children: <Widget>[
        Text("名称：",),
        Expanded(
          child: TextField(
            controller: _nameController,),
        )
      ],
    );
  }

  Widget getCreatedRow() {
    return Row(
      children: <Widget>[
        Text("创建时间："),
        Expanded(
          child: Text(DateUtils.formatDate(_created)),
        ),
        OutlineButton(
          child: Text("更改"),
          onPressed: () async {
            DateTime dt =
              DateTime.fromMillisecondsSinceEpoch(_created);
            var result = await showDatePicker(
                context: context,
                initialDate: dt,
                firstDate: dt.add(Duration(days: -365)),
                lastDate: dt.add(Duration(days: 365)));
            if (result != null) {
              setState(() {
                _created = result.millisecondsSinceEpoch;
              });
            }
          }
        )
      ],
    );
  }

  Widget getDeadlineRow() {
    return Row(
      children: <Widget>[
        Text("截至时间："),
        Expanded(
          child: Text(
              _deadline > 0
                  ? DateUtils.formatDate(_deadline)
                  : "无"),
        ),
        OutlineButton(
          child: Text("更改"),
          onPressed: () async {
            DateTime dt = _deadline > 0
                ? DateTime.fromMillisecondsSinceEpoch(_deadline)
                : DateTime.now();
            var result = await showDatePicker(
                context: context,
                initialDate: dt,
                firstDate: dt.add(Duration(days: -365)),
                lastDate: dt.add(Duration(days: 365)));
            if (result != null) {
              setState(() {
                _deadline = result.millisecondsSinceEpoch;
              });
            }
          }
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑项目"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: saveProject,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            getNameRow(),
            Divider(),
            getCreatedRow(),
            Divider(),
            getDeadlineRow()
          ],
        ),
      ),
    );
  }
}