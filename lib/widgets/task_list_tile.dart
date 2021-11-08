import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list_with_provider/pages/list_page.dart';
import 'package:to_do_list_with_provider/widgets/are_you_sure_dialog.dart';

class TaskListTile extends StatelessWidget {
  TaskListTile({Key? key, required this.list}) : super(key: key);
  final QueryDocumentSnapshot list;
  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: ListTile(
        tileColor: Colors.purple[100],
        leading: Icon(
          Icons.list_alt_rounded,
          color: Colors.blueGrey,
        ),
        title: Text(
          list["title"],
          style: TextStyle(color: Colors.deepPurple),
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
      actionPane: SlidableScrollActionPane(),
      secondaryActions: [
        Container(
          child: SlideAction(
            child: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
          ),
        ),
        Container(
          child: SlideAction(
            onTap: () => showDialog(
              context: context,
              builder: (context) => AreYouSureDialog(list: list),
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
      ],
    );
  }
}
