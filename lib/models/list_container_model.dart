import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/models/to_do_model.dart';

class ListContainerModel extends ChangeNotifier {
  ListContainerModel({required this.index}) {
    index = this.index;
  }

  int index;
  List<ToDoModel> listContainer = [];

  addList(ToDoModel toDoModel) {
    listContainer.add(toDoModel);
    notifyListeners();
  }
}
