import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/services/firestore.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';
import 'package:to_do_list_with_provider/widgets/add_dialog.dart';
import 'package:to_do_list_with_provider/widgets/task_tile.dart';

class ListPage extends StatelessWidget {
  ListPage({Key? key, this.list}) : super(key: key);
  final DocumentSnapshot? list;
  @override
  Widget build(BuildContext context) {
    var firestore = FireStoreService();
    return StreamBuilder(
      stream: firestore.orderedTasks(list!.reference).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          // appBar: AppBar(
          //   title: Center(
          //     child: Text(
          //       "TO DO LIST",
          //       style: TextStyle(fontSize: 25),
          //     ),
          //   ),
          //   automaticallyImplyLeading: false,
          // ),
          body: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Text(
                    "${list!["title"]}",
                    style: TextStyle(
                      color: Color(0xffff6434),
                      fontSize: 40.0,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.purple,
                      Colors.deepPurpleAccent,
                    ]),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  child: ListView.separated(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var task = snapshot.data.docs[index];
                      return TaskTile(
                        index: index,
                        sortedList: firestore.orderedTasks(list!.reference),
                        // listTitle: listTitle!,
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
                )),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    color: Colors.deepPurple[200],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.deepPurple[100],
                        heroTag: null,
                        child: Icon(Icons.add),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AddTask(list: list!),
                          );
                        },
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.deepPurple[100],
                        heroTag: null,
                        child: Icon(
                          Icons.add_box_outlined,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListTitlePage()));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
