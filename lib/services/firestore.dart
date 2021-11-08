import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';

class FireStoreService {
  CollectionReference listsCollection =
      FirebaseFirestore.instance.collection("lists");

  addList(String listTitle, TaskListManager taskListManager) {
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

  removeTask(QueryDocumentSnapshot task) async {
    task.reference.delete();
  }

  Future<void> removeList(DocumentSnapshot list) async {
    QuerySnapshot tasks =
        await listsCollection.doc(list.id).collection("tasks").get();
    list.reference.set({"title": ""});
    for (var task in tasks.docs) {
      task.reference.delete();
    }
    list.reference.delete();
  }

  void editTask(QueryDocumentSnapshot doc, TaskModel task) {
    doc.reference.update(task.toMap());
  }

  void checkboxToggle(QueryDocumentSnapshot doc, bool checkboxState) {
    doc.reference.update({"isCompleted": checkboxState});
  }

  // // Future<void> newMethod(String listTitle) async {
  // //   CollectionReference lists = FirebaseFirestore.instance.collection("list");
  // //   DocumentSnapshot snapshot = await lists.doc("list1").get();
  // //   var data = snapshot.data() as Map;
  // //   var tasksData = data["tasks"] as List<dynamic>;
  // //   // print(data["tasks"][1]["isCompleted"]);

  // //   CollectionReference myLists =
  // //       FirebaseFirestore.instance.collection("lists");
  // //   DocumentSnapshot list = await myLists.doc("list1").get();
  // //   DocumentSnapshot task = await list.reference
  // //       .collection("tasks")
  // //       .doc("8B7Sv8YUgM36sW2jR6Wf")
  // //       .get();
  // //   CollectionReference col = list.reference.collection("tasks");
  // //   List<dynamic> taskList = await col.snapshots().toList();

  // //   List<DocumentSnapshot> aaa = [];
  // //   // DocumentSnapshot task1 = await col.doc("task1").get();

  // //   // col.get().then((snapshot) => snapshot.docs.forEach((task) {
  // //   //       print(task.data());
  // //   //     }));
  // //   // var t1 = task1.data() as Map;
  // //   // var list1Data = list.data() as Map;

  // //   // print(task["isCompleted"]);
  // // }

  newMethod() {
    // listsCollection.get().then((snapshot) => snapshot.docs.forEach((list) {
    //       print(list.data());
    //     }));

    listsCollection
        .get()
        .then((snapshot) => snapshot.docs.first.reference.delete());
  }
}
