import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';

class TaskListManager extends ChangeNotifier {
  String? listTitle;
  List<TaskModel> _taskList = [];

  UnmodifiableListView<TaskModel> get taskList {
    return UnmodifiableListView(_taskList);
  }

  int get listLength {
    return _taskList.length;
  }

  addTask(TaskModel taskModel) {
    _taskList.add(taskModel);
    notifyListeners();
  }

  removeTask(taskModel) {
    _taskList.remove(taskModel);
    notifyListeners();
  }

  clearList() {
    _taskList.clear();
    notifyListeners();
  }

  setTitle(String title) {
    listTitle = title;
    notifyListeners();
  }

  checkboxToggle(TaskModel task) {
    task.toggle();
    notifyListeners();
  }
}
