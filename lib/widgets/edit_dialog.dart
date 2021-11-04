import 'package:flutter/material.dart';

class EditDialog extends StatelessWidget {
  const EditDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Edit Task",
      ),
      actions: [
        TextButton(onPressed: () {}, child: Text("Edit")),
        TextButton(onPressed: () {}, child: Text("Cancel"))
      ],
    );
  }
}
