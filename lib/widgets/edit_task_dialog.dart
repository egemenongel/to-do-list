import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/services/database_service.dart';
import 'package:to_do_list_with_provider/widgets/task_form.dart';

class EditTaskDialog extends StatelessWidget {
  EditTaskDialog({
    Key? key,
    required this.index,
    required this.sortedList,
  }) : super(key: key);
  final index;
  final Query sortedList;
  final DatabaseService firestore = DatabaseService();
  final taskTitle = TextEditingController();
  final startTime = TextEditingController();
  final finishTime = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final duration = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sortedList.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        //SET INITIAL VALUES
        var task = snapshot.data.docs[index];
        taskTitle.text = task["title"];
        startTime.text = task["startTime"];
        finishTime.text = task["finishTime"];
        duration.text = task["duration"];
        return AlertDialog(
          backgroundColor: Colors.purple[50],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.deepPurple,
              )),
          title: Text(
            "Edit Task",
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
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    firestore.editTask(
                        task,
                        TaskModel(
                          title: taskTitle.text,
                          startTime: startTime.text,
                          finishTime: finishTime.text,
                          duration: duration.text,
                          timeStamp: task["timeStamp"], //To make it same
                          isCompleted: task["isCompleted"],
                        ));
                    Navigator.pop(context);
                  }
                },
                child: Text("Edit")),
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Cancel"))
          ],
          actionsAlignment: MainAxisAlignment.spaceBetween,
        );
      },
    );
  }
}
