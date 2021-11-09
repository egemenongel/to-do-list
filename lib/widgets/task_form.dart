import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/widgets/time_field.dart';

class TaskForm extends StatefulWidget {
  TaskForm({
    Key? key,
    required this.formKey,
    required this.taskTitle,
    required this.startTime,
    required this.finishTime,
    required this.duration,
  }) : super(key: key);
  final GlobalKey formKey;
  final TextEditingController taskTitle;
  final TextEditingController startTime;
  final TextEditingController finishTime;
  final TextEditingController duration;
  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.deepPurple));
  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (widget.startTime.text.isNotEmpty ||
          widget.finishTime.text.isNotEmpty) {
        Provider.of<TaskListManager>(context, listen: false).changeBool(false);
      } else {
        Provider.of<TaskListManager>(context, listen: false).changeBool(true);
      }
      _disableTimeField();
    });
  }

  bool isEnabled = true;
  // bool dur = true;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: [
              TextFormField(
                  controller: widget.taskTitle,
                  decoration: InputDecoration(
                    labelText: "New Task",
                    labelStyle: TextStyle(color: Colors.deepPurple),
                  ),
                  autofocus: true,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter a task" : null),
              ExpansionTile(
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                title: Text("Add details"),
                // Target Dates?
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Add target complete time",
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.deepPurple),
                      color: Colors.purple[50],
                    ),
                    //Target Time Section
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 90,
                              child: TimeField(
                                clearButton: () {
                                  widget.startTime.clear();
                                  if (widget.startTime.text.isEmpty &&
                                      widget.finishTime.text.isEmpty) {
                                    Provider.of<TaskListManager>(context,
                                            listen: false)
                                        .changeBool(true);
                                  }
                                },
                                controller: widget.startTime,
                                labelText: "Start Time",
                                enabled: isEnabled,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 90,
                              child: TimeField(
                                clearButton: () {
                                  widget.finishTime.clear();
                                  if (widget.startTime.text.isEmpty &&
                                      widget.finishTime.text.isEmpty) {
                                    Provider.of<TaskListManager>(context,
                                            listen: false)
                                        .changeBool(true);
                                  }
                                },
                                controller: widget.finishTime,
                                labelText: "Finish Time",
                                enabled: isEnabled,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  height: 20,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 50,
                                child: Text(
                                  "OR",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  height: 20,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              child: TextFormField(
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    setState(() {
                                      isEnabled = false;
                                    });
                                  } else {
                                    setState(() {
                                      isEnabled = true;
                                    });
                                  }
                                },
                                textAlign: TextAlign.center,
                                controller: widget.duration,
                                enabled: Provider.of<TaskListManager>(context,
                                        listen: true)
                                    .duration,
                                validator: (value) {},
                                decoration: InputDecoration(
                                  border: widget._border,
                                  labelText: "Duration",
                                  labelStyle:
                                      TextStyle(color: Colors.deepPurple),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ), //Due date
                  // showDatePicker(
                  //         context: context,
                  //         initialDate: DateTime.now(),
                  //         firstDate: DateTime(2015, 1, 1),
                  //         lastDate: DateTime(2025, 1, 1))),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    //Due date
                    decoration: InputDecoration(
                      border: widget._border,
                      labelText: "Due Date",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    onChanged: (val) => print(val),
                    //Notes
                    keyboardType: TextInputType.multiline,
                    minLines: 1, //Normal textInputField will be displayed
                    maxLines: 5, // when user presses enter it will adapt to it
                    decoration: InputDecoration(
                      border: widget._border,
                      labelText: "Add Notes",
                      labelStyle: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void _disableTimeField() {
    if (widget.duration.text.isNotEmpty) {
      setState(() {
        isEnabled = false;
      });
    }
  }
}
