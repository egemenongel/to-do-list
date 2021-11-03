import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile({
    required this.taskTitle,
    required this.startTime,
    required this.finishTime,
    required this.isCompleted,
    required this.checkboxCallback,
  });

  final String taskTitle;
  final String startTime;
  final String finishTime;
  final bool isCompleted;
  final void Function(bool?)? checkboxCallback;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {},
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
}
