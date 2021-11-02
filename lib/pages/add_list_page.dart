import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/widgets/bottom_app_bar.dart';

class AddListPage extends StatefulWidget {
  AddListPage({Key? key}) : super(key: key);

  @override
  State<AddListPage> createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  final taskTitle = TextEditingController();
  final startDate = TextEditingController();
  final finishDate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _taskListManager = Provider.of<TaskListManager>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            "${_taskListManager.listTitle}",
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
                child: Column(
              children: [
                TextFormField(
                  controller: taskTitle,
                  decoration: InputDecoration(labelText: "New Task"),
                  autofocus: true,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Start Date"),
                  controller: startDate,
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Finish Date"),
                  controller: finishDate,
                )
              ],
            )),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              TaskModel task = TaskModel(
                title: taskTitle.text,
              );
              _taskListManager.addTask(task);
              taskTitle.clear();
            },
            child: Text("Add"),
          ),
          Expanded(
            child: Consumer<TaskListManager>(
                builder: (context, taskListManager, child) => ListView.builder(
                    itemCount: taskListManager.listLength,
                    itemBuilder: (BuildContext context, int index) {
                      var task = taskListManager.taskList[index];
                      return ListTile(
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () => taskListManager.removeTask(task),
                        ),
                        subtitle: Text(
                            "${task.startDate!.format(context).split(" ")[0]}"),
                        title: Row(
                          children: [
                            Text("${index + 1}. "),
                            Text(
                              task.title,
                            ),
                          ],
                        ),
                      );
                    })),
          ),
        ],
      ),
      bottomNavigationBar: ListBottomBar(),
    );
  }
}
