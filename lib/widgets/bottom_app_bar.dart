import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/pages/list_page.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class ListBottomBar extends StatelessWidget {
  ListBottomBar({Key? key}) : super(key: key);
  int taskId = 0;
  String? title;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
                onPressed: () {
                  context.read<TaskListManager>().clearList();
                },
                child: Text("Clear List")),
          ),
          Container(
            height: 30,
            child: VerticalDivider(color: Colors.grey),
            width: 0,
          ),
          Expanded(
              child: TextButton(
                  style: ButtonStyle(),
                  onPressed: () {
                    addTasks(
                        Provider.of<TaskListManager>(context, listen: false));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ListPage()));
                  },
                  child: Text("Submit")))
        ],
      ),
    );
  }

  void addTasks(TaskListManager taskListManager) {
    for (TaskModel task in taskListManager.taskList) {
      addTask(task);
    }
  }

  Future<void> addTask(TaskModel task) {
    DocumentReference lists =
        FirebaseFirestore.instance.collection("storage").doc("lists");
    taskId++;
    CollectionReference currentList = lists.collection("list1"); //listTitle

    return currentList
        .doc(task.title) //taskId
        .set({
          "isCompleted": task.isCompleted,
          "startTime": task.startTime,
          "finishTime": task.finishTime,
          "duration": task.duration,
        })
        .then((value) => print("Task Added"))
        .catchError((error) => print("Failed to add task: $error"));
  }
}
