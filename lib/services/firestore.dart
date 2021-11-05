import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class FireStoreService {
  CollectionReference list1 = FirebaseFirestore.instance
      .collection("storage")
      .doc("lists")
      .collection("list1");

  Stream<QuerySnapshot> get tasks {
    return list1.snapshots();
  }

  Future<int> get length async {
    return await tasks.length;
  }

  late Query orderById = list1.orderBy("id", descending: false);

  late Query orderByTimestamp = list1.orderBy("timeStamp", descending: false);

  void addTasksToDatabase(TaskListManager taskListManager) {
    for (TaskModel task in taskListManager.taskList) {
      // addTask(task, taskListManager);
      var currentTask =
          list1.doc("task${taskListManager.taskList.indexOf(task)}");
      currentTask.set({
        "id": taskListManager.taskList.indexOf(task),
        "title": task.title,
        "isCompleted": task.isCompleted,
        "startTime": task.startTime,
        "finishTime": task.finishTime,
        "duration": task.duration,
        "timeStamp": Timestamp.now(),
      });
    }
  }

  void checkboxToggle(QueryDocumentSnapshot task, bool checkboxState) {
    list1.doc("task${task["id"]}").update({"isCompleted": checkboxState});
  }

  Future addTask(TaskModel task) async {
    await list1.add(task.toMap());
  }

  Future removeTask(QueryDocumentSnapshot doc) async {
    await doc.reference.delete();
  }

  // void addTask() {
  //   list1.doc().set({taskModel});
  // }

  void editTask(QueryDocumentSnapshot task, String title, String startTime,
      String finishTime, String duration) {
    list1.doc("task${task["id"]}").update({
      "title": title,
      "startTime": startTime,
      "finishTime": finishTime,
      "duration": duration,
    });
  }

  // void deleteTask(QueryDocumentSnapshot task) {
  //   list1.doc("task${task["id"]}").delete();
  // }
}

// void deleteTask(TaskModel task, TaskListManager taskListManager) {
//   list1.doc("task${taskListManager.taskList.indexOf(task)}").delete();
// }

// void editTask(int index, String title, String startTime, String finishTime,
//     String duration) {
//   list1.doc("task$index").update({
//     "title": title,
//     "startTime": startTime,
//     "finishTime": finishTime,
//     "duration": duration,
//   });
// }

// void checkboxToggle(int index, bool checkboxState) {
//   list1.doc("task$index").update({"isCompleted": checkboxState});
// }

// addTasks(
//                 Provider.of<TaskListManager>(context, listen: false));

// void addTasks(TaskListManager taskListManager) {
//     for (TaskModel task in taskListManager.taskList) {
//       addTask(task, taskListManager);
//     }
//   }

// Future<void> addTask(TaskModel task, TaskListManager taskListManager) {
  //   DocumentReference lists =
  //       FirebaseFirestore.instance.collection("storage").doc("lists");
  //   taskId++;
  //   CollectionReference currentList = lists.collection("list1"); //listTitle

// return currentList
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