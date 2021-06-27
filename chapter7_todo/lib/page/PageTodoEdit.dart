import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/Project.dart';
import 'package:todo/model/Todo.dart';
import 'package:todo/state/ProjectState.dart';
import 'package:todo/state/TodoState.dart';
import 'package:todo/utils/DateUtils.dart';

class PageTodoEdit extends StatefulWidget {
  final Todo _todo;

  PageTodoEdit(this._todo);

  @override
  State<StatefulWidget> createState() {
    return _PageTodoEditState();
  }
}

class _PageTodoEditState extends State<PageTodoEdit> {
  TextEditingController _nameController;

  Project _project;
  int _created;
  int _deadline;
  int _finished;

  @override
  void initState() {
    super.initState();
    Todo originTodo = widget._todo;

    _nameController = TextEditingController(
        text:originTodo?.name ?? "");
    _created = originTodo?.created
        ?? DateTime.now().millisecondsSinceEpoch;
    _deadline = originTodo?.deadline ?? 0;
    _finished = originTodo?.finished ?? TODO_UNFINISHED;

    _project = originTodo != null
        ? Provider
          .of<ProjectState>(context, listen: false)
          .findProjectById(originTodo.project_id)
        : null;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  void saveTodo() {
    TodoState todoState = Provider.of<TodoState>(
        context, listen: false);

    if (widget._todo != null) {
      Todo todo = Todo();
      todo.id = widget._todo.id;
      todo.name = _nameController.text;
      todo.created = _created;
      todo.deadline = _deadline;
      todo.finished = _finished;
      todo.project_id = _project?.id ?? null;
      todoState.updateTodo(todo);
      // 更新
    } else {
      // 新建
      Todo todo = Todo();
      todo.name = _nameController.text;
      todo.created = _created;
      todo.deadline = _deadline;
      todo.project_id = _project?.id ?? null;
      todoState.createTodo(todo);
    }
    Navigator.pop(context);
  }

  Widget getNameRow() {
    return Row(
      children: <Widget>[
        Text("名称：",),
        Expanded(
          child: TextField(controller: _nameController,),
        )
      ],
    );
  }

  Widget getProjectRow() {
    return Row(
      children: <Widget>[
        Text("项目："),
        Expanded(
          child: Text(_project?.name ?? "无"),
        ),
        OutlineButton(
          child: Text("选择"),
          onPressed: () => showProjectDialog().then((project) {
            if (project == null) return;

            setState(() {
              _project = project;
            });
          }),
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
          },
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
          },
        )
      ],
    );
  }

  Widget getFinishedRow() {
    return Row(
      children: <Widget>[
        Text("完成状态："),
        IconButton(
          icon: Icon(
            _finished == TODO_FINISHED
                ? Icons.check_circle
                : Icons.check_circle_outline,
            color: _finished == TODO_FINISHED
                ? Colors.green
                : Colors.grey,
          ),
          onPressed: () => setState(() {
            _finished = _finished == TODO_FINISHED
                ? TODO_UNFINISHED : TODO_FINISHED;
          }),
        )
      ],
    );
  }

  Future<Project> showProjectDialog() async {
    List<Project> projectList = Provider
            .of<ProjectState>(context, listen: false)
            .projectList;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("所属项目"),
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(projectList[index].name),
                    onTap: () =>
                        Navigator.pop(context, projectList[index]),
                  );
                },
                itemCount: projectList.length,
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("编辑待办事项"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: saveTodo,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ListView(
          children: [
            getNameRow(),     // 待办项名称
            Divider(),
            getProjectRow(),  // 待办所属项目
            Divider(),
            getCreatedRow(),  // 待办创建时间
            Divider(),
            getDeadlineRow(), // 待办截至时间
            Divider(),
            getFinishedRow()
          ],
        ),
      ),
    );
  }
}