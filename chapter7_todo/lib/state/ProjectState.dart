import 'package:flutter/material.dart';
import 'package:todo/data/ProjectManager.dart';
import 'package:todo/model/Project.dart';

class ProjectState with ChangeNotifier {
  List<Project> projectList = [];

  // 当前选中项目
  String selectedProjectName;

  void selectProject(String projectName) {
    selectedProjectName = projectName;
    notifyListeners();
  }

  Project findProjectById(int projectId) {
    for (Project p in projectList) {
      if (p.id == projectId) {
        return p;
      }
    }
    return null;
  }

  void updateProject(Project project) async {
    await ProjectManager.updateProject(project);

    int index = projectList.indexWhere(
            (element) => element.id == project.id);

    if (projectList[index].name == selectedProjectName) {
      selectedProjectName = project.name;
    }

    projectList[index] = project;

    notifyListeners();
  }

  void createProject(Project project) async {
    await ProjectManager.createProject(project);
    projectList.add(project);
    notifyListeners();
  }

  void getAllProject() async {
    projectList = await ProjectManager.getAllProject();
    notifyListeners();
  }
}