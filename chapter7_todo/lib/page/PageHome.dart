import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/component/TodoListTile.dart';
import 'package:todo/model/Project.dart';
import 'package:todo/model/Todo.dart';
import 'package:todo/page/PageProjectEdit.dart';
import 'package:todo/page/PageTodoEdit.dart';
import 'package:todo/state/ProjectState.dart';
import 'package:todo/state/TodoState.dart';

class PageHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageHomeState();
  }
}

class _PageHomeState extends State<PageHome> {

  @override
  void initState() {
    super.initState();
    Provider
        .of<TodoState>(context, listen: false)
        .getAllTodo();
    Provider
        .of<ProjectState>(context, listen: false)
        .getAllProject();
  }

  Widget getDrawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DrawerHeader(
            child: Text("项目列表", style: TextStyle(fontSize: 24)),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          Expanded(
            child: getProjectList(),
          ),
          MaterialButton(
              child: Text("创建项目"),
              onPressed: () =>
                Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PageProjectEdit(null))),
          )
        ],
      ),
    );
  }

  Widget getProjectList() {
    return Consumer<ProjectState>(
      builder: (context, projectState, widget) {
        List<Project> projectList = projectState.projectList;
        List<String> projectNames = List.generate(
            projectList.length, (index) => projectList[index].name);
        projectNames.insert(0, "所有");


        return ListView.builder(
          itemBuilder: (context, index) {
            bool selected =
                projectState.selectedProjectName == projectNames[index];

            return MaterialButton(
              child: Text(
                projectNames[index],
                style: TextStyle(
                  color: selected ? Colors.blue : Colors.grey
                ),
              ),
              onPressed: () =>
                  projectState.selectProject(projectNames[index]),
              onLongPress: () {
                if (index == 0) return;
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) =>
                        PageProjectEdit(projectList[index - 1])
                ));
              },
            );
          },
          itemCount: projectNames.length,
        );
      }
    );
  }

  Widget getTodoList() {
    return Consumer2<TodoState, ProjectState>(
      builder: (context, todoState, projectState, widget) {
        List<Todo> todoList;

        String filterProject = projectState.selectedProjectName;
        if (filterProject == null || filterProject.isEmpty) {
          todoList = todoState.todoList;
        } else if (filterProject == "所有") {
          todoList = todoState.todoList;
        } else {
          todoList = todoState.todoList.where((todo) =>
            projectState.findProjectById(todo.project_id)?.name
                == filterProject).toList();
        }

        return ListView.separated(
          itemBuilder: (context, index) {
            return TodoListTile(todoList[index]);
          },
          itemCount: todoList.length,
          separatorBuilder: (context, index) => Divider(),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      drawer: getDrawer(),
      body: getTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) =>
                      PageTodoEdit(null))),
        child: Icon(Icons.add),
      ),
    );
  }
}