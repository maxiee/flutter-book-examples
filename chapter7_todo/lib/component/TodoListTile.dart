import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/Todo.dart';
import 'package:todo/page/PageTodoEdit.dart';
import 'package:todo/state/ProjectState.dart';
import 'package:todo/state/TodoState.dart';
import 'package:todo/utils/DateUtils.dart';

class TodoListTile extends StatelessWidget {
  Todo _todo;

  TodoListTile(this._todo);

  void toggleTodo(BuildContext context) {
    Todo todo = Todo.copy(_todo);
    todo.finished = todo.finished == TODO_FINISHED
        ? TODO_UNFINISHED : TODO_FINISHED;
    Provider.of<TodoState>(context, listen: false).updateTodo(todo);
  }

  void onItemClick(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => PageTodoEdit(_todo)
    ));
  }

  Widget getBadge(String text) {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.blue
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  List<Widget> getSubtitle(BuildContext context) {
    return [
      if (_todo.project_id != null) getBadge(
        Provider
            .of<ProjectState>(context)
            .findProjectById(_todo.project_id).name
      ),
      if (_todo.deadline > 0)
        getBadge("截至：${DateUtils.formatDate(_todo.deadline)}")
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> subtitle = getSubtitle(context);

    return ListTile(
      title: Text(
        _todo.name,
        style: TextStyle(fontSize: 18),
      ),
      subtitle: subtitle.isNotEmpty
          ? Row(children: subtitle) : null,
      trailing: IconButton(
        icon: Icon(
          _todo.finished == TODO_FINISHED
              ? Icons.check_circle
              : Icons.check_circle_outline,
          color: _todo.finished == TODO_FINISHED
              ? Colors.green
              : Colors.grey,
        ),
        onPressed: () => toggleTodo(context),
      ),
      onTap: () => onItemClick(context),
    );
  }
}