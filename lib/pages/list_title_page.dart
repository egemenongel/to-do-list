import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/pages/add_list_page.dart';

class ListTitlePage extends StatefulWidget {
  ListTitlePage({Key? key}) : super(key: key);

  @override
  _ListTitlePage createState() => _ListTitlePage();
}

class _ListTitlePage extends State<ListTitlePage> {
  @override
  Widget build(BuildContext context) {
    var listTitle = TextEditingController();
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            "TO DO LIST",
            style: TextStyle(fontSize: 35, color: Colors.green[700]),
          ),
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Form(
              child: TextFormField(
                controller: listTitle,
                decoration: InputDecoration(
                    labelText:
                        "List Title (Shopping List, Daily To Do List...)",
                    labelStyle: TextStyle(fontSize: 14)),
                autofocus: true,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddListPage()));
            },
            child: Text("Next"),
          ),
        ],
      )),
    );
  }
}
