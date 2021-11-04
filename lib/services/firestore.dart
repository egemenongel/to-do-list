import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';

class FireStoreService {
  CollectionReference list1 = FirebaseFirestore.instance
      .collection("storage")
      .doc("lists")
      .collection("list1");

  void addTask(TaskModel task) {
    list1.doc("task1").set({
      "title": task.title,
      "isCompleted": task.isCompleted,
      "startTime": task.startTime,
      "finishTime": task.finishTime,
      "duration": task.duration,
    });
  }
}
// addTasks(
//                 Provider.of<TaskListManager>(context, listen: false));

//  void addTasks(TaskListManager taskListManager) {
//     for (TaskModel task in taskListManager.taskList) {
//       addTask(task, taskListManager);
//     }
//   }

  // Future<void> addTask(TaskModel task, TaskListManager taskListManager) {
  //   DocumentReference lists =
  //       FirebaseFirestore.instance.collection("storage").doc("lists");
  //   taskId++;
  //   CollectionReference currentList = lists.collection("list1"); //listTitle

  //   return currentList
  //       .doc(
  //           "task${currentList.get().then((value) => value.docs.length.toString())}") //taskId
  //       .set({
  //         "title": task.title,
  //         "isCompleted": task.isCompleted,
  //         "startTime": task.startTime,
  //         "finishTime": task.finishTime,
  //         "duration": task.duration,
  //       })
  //       .then((value) => print("Task Added"))
  //       .catchError((error) => print("Failed to add task: $error"));
  // }