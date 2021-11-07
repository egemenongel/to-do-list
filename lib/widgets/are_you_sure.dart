import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/services/firestore.dart';

class AreYouSureDialog extends StatelessWidget {
  AreYouSureDialog({Key? key, this.list}) : super(key: key);
  final DocumentSnapshot? list;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete List"),
      content: Text("Do you want to delete this list?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                FireStoreService().removeList(list!);
                Navigator.pop(context);
              },
              child: Text("Yes"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("No"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
              ),
            ),
          ],
        )
      ],
    );
  }
}
