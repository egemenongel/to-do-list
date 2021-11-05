import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/services/firestore.dart';
import 'package:to_do_list_with_provider/widgets/task_form.dart';

class AddTask extends StatelessWidget {
  AddTask({Key? key}) : super(key: key);
  final FireStoreService firestore = FireStoreService();
  final taskTitle = TextEditingController();
  final startTime = TextEditingController();
  final finishTime = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final duration = TextEditingController();
  var id = 100;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.deepPurple,
          )),
      title: Text(
        "Add Task",
      ),
      content: TaskForm(
        formKey: _formKey,
        taskTitle: taskTitle,
        startTime: startTime,
        finishTime: finishTime,
        duration: duration,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      actions: [
        // firestore.orderById.snapshots()
        TextButton(
            onPressed: () {
              firestore.addTask(TaskModel(
                title: taskTitle.text,
                isCompleted: false,
                startTime: startTime.text,
                finishTime: finishTime.text,
                duration: duration.text,
                timeStamp: Timestamp.now(),
              ));
              Navigator.pop(context);
            },
            child: Text("Add")),
        TextButton(
            onPressed: () => Navigator.pop(context), child: Text("Cancel"))
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }

  // Future addTask(TaskModel task) async{
  //   try{
  //     await firestore.list1.add(task.toMap());
  //   }
  // }
}
