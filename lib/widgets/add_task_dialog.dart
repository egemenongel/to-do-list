import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/services/database_service.dart';
import 'package:to_do_list_with_provider/widgets/task_form.dart';

class AddTaskDialog extends StatelessWidget {
  AddTaskDialog({Key? key, required this.list}) : super(key: key);
  final DocumentSnapshot? list;
  final DatabaseService firestore = DatabaseService();
  final taskTitle = TextEditingController();
  final startTime = TextEditingController();
  final finishTime = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final duration = TextEditingController();
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
      content: SingleChildScrollView(
        child: TaskForm(
          formKey: _formKey,
          taskTitle: taskTitle,
          startTime: startTime,
          finishTime: finishTime,
          duration: duration,
        ),
      ),
      actions: [
        // firestore.orderById.snapshots()
        TextButton(
            onPressed: () {
              firestore.addTask(
                  list!.reference,
                  TaskModel(
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
}