import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/services/firestore.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';
import 'package:to_do_list_with_provider/widgets/task_tile.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firestore = FireStoreService();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "TO DO LIST",
            style: TextStyle(fontSize: 25),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "${context.read<TaskListManager>().listTitle}",
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
                child: StreamBuilder(
              stream: firestore.orderById.snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return ListView.separated(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var task = snapshot.data.docs[index];
                    return TaskTile(
                      taskTitle: task["title"],
                      startTime: task["startTime"],
                      finishTime: task["finishTime"],
                      duration: task["duration"],
                      isCompleted: task["isCompleted"],
                      checkboxCallback: (checkboxState) =>
                          firestore.checkboxToggle(task, checkboxState!),
                    );
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 10,
                      color: Colors.transparent,
                    );
                  },
                );
              },
            )),
            Container(
              color: Colors.purple[200],
              height: 40,
            ),
            // Expanded(
            //   child: Consumer<TaskListManager>(
            //     builder: (_, taskListManager, __) => ListView.separated(
            //       itemCount: taskListManager.listLength,
            //       itemBuilder: (BuildContext context, int index) {
            //         var task = taskListManager.taskList[index];
            //         return TaskTile(
            //           taskTitle: task.title,
            //           isCompleted: task.isCompleted!,
            //           startTime: task.startTime!,
            //           finishTime: task.finishTime!,
            //           duration: task.duration!,
            //           checkboxCallback: (checkboxState) =>
            //               taskListManager.checkboxToggle(task),
            //         );
            //       },
            //       padding: EdgeInsets.symmetric(horizontal: 20),
            //       separatorBuilder: (BuildContext context, int index) {
            //         return Divider(
            //           height: 10,
            //           color: Colors.transparent,
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListTitlePage()));
        },
      ),
    );
  }
}
