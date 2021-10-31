import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/models/task_model.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/pages/home_page.dart';

class AddListPage extends StatelessWidget {
  AddListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey _key = GlobalKey();
    var taskTitle = TextEditingController();
    var _taskListManager = Provider.of<TaskListManager>(context, listen: false);
    return Scaffold(
      body: Center(
          child: Column(
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
              child: TextFormField(
                controller: taskTitle,
                decoration: InputDecoration(labelText: "New Task"),
                autofocus: true,
              ),
              key: _key,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              TaskModel task =
                  TaskModel(title: taskTitle.text, isCompleted: false);
              _taskListManager.addTask(task);
              taskTitle.clear();
            },
            child: Text("Add"),
          ),
          Expanded(
            child: Consumer<TaskListManager>(
                builder: (context, taskListManager, child) => ListView.builder(
                    itemCount: taskListManager.taskList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var task = taskListManager.taskList[index];
                      return ListTile(
                        trailing: IconButton(
                          icon: Icon(Icons.remove_circle),
                          onPressed: () => taskListManager.removeTaskAt(index),
                        ),
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
      )),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextButton(
                  onPressed: () {
                    _taskListManager.clearList();
                  },
                  child: Text("Clear List")),
            ),
            Container(height: 30, child: VerticalDivider(color: Colors.grey)),
            Expanded(
              child: Container(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Text("Submit"))),
            )
          ],
        ),
      ),
    );
  }
}
