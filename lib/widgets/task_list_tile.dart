import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_with_provider/pages/list_page.dart';
import 'package:to_do_list_with_provider/services/database_service.dart';
import 'package:to_do_list_with_provider/utils/task_list_manager.dart';
import 'package:to_do_list_with_provider/widgets/dialogs/delete_list_dialog.dart';
import 'package:to_do_list_with_provider/widgets/dialogs/edit_list_dialog.dart';

class TaskListTile extends StatelessWidget {
  TaskListTile({Key? key, required this.list, required this.index})
      : super(key: key);
  final int index;
  final DocumentSnapshot list;
  @override
  Widget build(BuildContext context) {
    int i = 0;
    int func(AsyncSnapshot snapshot) {
      i = 0;
      for (var task in snapshot.data.docs) {
        if (task.get("isCompleted") == true) i++;
      }
      return i;
    }

    return StreamBuilder(
      stream: list.reference.collection("tasks").snapshots(),
      builder: (_, AsyncSnapshot snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        func(snapshot);
        return Slidable(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: index % 2 == 1
                    ? Colors.lightBlue[200]
                    : Colors.lightBlue[900],
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                )),
            child: ListTile(
              tileColor: Colors.white,
              title: Text(
                list["title"],
                style: TextStyle(
                    color: index % 2 == 1 ? Colors.indigo[800] : Colors.white),
              ),
              trailing: Text(
                "$i/${snapshot.data.docs!.length}",
                style: TextStyle(
                    color: index % 2 == 1 ? Colors.indigo[800] : Colors.white),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListPage(
                        list: list,
                      ),
                    ));
              },
            ),
          ),
          actionPane: SlidableScrollActionPane(),
          actions: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: SlideAction(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => DeleteListDialog(list: list),
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(color: Colors.white),
                top: BorderSide(
                  color: Colors.white,
                ),
              )),
              child: SlideAction(
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => EditListDialog(
                    list: list,
                  ),
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
