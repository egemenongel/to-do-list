import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class FireStoreService {
  CollectionReference listsCollection =
      FirebaseFirestore.instance.collection("lists");

  void addList(String listTitle, TaskListManager taskListManager) {
    for (TaskModel task in taskListManager.taskList) {
      listsCollection.doc(listTitle).set({
        "title": listTitle,
      });
      var currentTask =
          listsCollection.doc(listTitle).collection("tasks").doc();
      currentTask.set({
        "title": task.title,
        "isCompleted": task.isCompleted,
        "startTime": task.startTime,
        "finishTime": task.finishTime,
        "duration": task.duration,
        "timeStamp": Timestamp.now(),
      });
    }
  }

  Query orderedTasks(String listTitle) {
    return listsCollection
        .doc(listTitle)
        .collection("tasks")
        .orderBy("timeStamp");
  }

  Future addTask(String listTitle, TaskModel task) async {
    await listsCollection.doc(listTitle).collection("tasks").add(task.toMap());
  }

  void removeTask(QueryDocumentSnapshot task) {
    task.reference.delete();
  }

  void removeList(DocumentSnapshot list) {
    list.reference.delete();
  }

  void editTask(QueryDocumentSnapshot doc, TaskModel task) {
    doc.reference.update(task.toMap());
  }

  void checkboxToggle(QueryDocumentSnapshot doc, bool checkboxState) {
    doc.reference.update({"isCompleted": checkboxState});
  }
}
