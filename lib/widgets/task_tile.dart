import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile({
    required this.taskTitle,
    required this.startTime,
    required this.finishTime,
    required this.duration,
    required this.isCompleted,
    required this.checkboxCallback,
  });

  final String taskTitle;
  final String startTime;
  final String finishTime;
  final String duration;
  final bool isCompleted;
  final void Function(bool?)? checkboxCallback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => myDialog,
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: Colors.deepOrange,
            )),
        title: Text(
          taskTitle,
          style: TextStyle(
              decoration: isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              decorationColor: Theme.of(context).primaryColor),
        ),
        leading: Checkbox(
          value: isCompleted,
          onChanged: checkboxCallback,
          activeColor: Colors.green,
        ),
        trailing: Container(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              duration != ""
                  ? Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "$duration mins",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : SizedBox(),
              startTime != ""
                  ? Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        startTime,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : SizedBox(),
              finishTime != ""
                  ? Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        finishTime,
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ));
  }

  final AlertDialog myDialog = AlertDialog(
    title: Text(
      "Edit Task",
    ),
    actions: [
      TextButton(onPressed: () {}, child: Text("Edit")),
      TextButton(onPressed: () {}, child: Text("Cancel"))
    ],
  );
}
