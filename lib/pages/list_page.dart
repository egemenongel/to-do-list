import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/services/firestore.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';
import 'package:to_do_list_with_provider/widgets/add_dialog.dart';
import 'package:to_do_list_with_provider/widgets/task_tile.dart';

class ListPage extends StatelessWidget {
  ListPage({Key? key, this.index}) : super(key: key);
  final String? index;
  @override
  Widget build(BuildContext context) {
    var firestore = FireStoreService();
    return StreamBuilder(
      stream:
          firestore.listStorage.doc("$index").collection("tasks").snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
                  "$index",
                  style: Theme.of(context).textTheme.headline2,
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var task = snapshot.data.docs[index];
                      return TaskTile(
                        index: index,
                        taskTitle: task["title"],
                        startTime: task["startTime"],
                        finishTime: task["finishTime"],
                        duration: task["duration"],
                        isCompleted: task["isCompleted"],
                        checkboxCallback: (checkboxState) =>
                            firestore.checkboxToggle(task, checkboxState!),
                        deleteCallback: () => firestore.removeTask(task),
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
                  ),
                ),
              ],
            ),
          ),
          persistentFooterButtons: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddTask(),
                    );
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.add_box_outlined),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ListTitlePage()));
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
