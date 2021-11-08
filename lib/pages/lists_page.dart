import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/pages/list_page.dart';
import 'package:to_do_list_with_provider/pages/list_title_page.dart';
import 'package:to_do_list_with_provider/services/firestore.dart';
import 'package:to_do_list_with_provider/widgets/are_you_sure.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firestore = FireStoreService();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Lists"),
      ),
      body: StreamBuilder(
        stream: firestore.listsCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.all(10),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              var list = snapshot.data.docs[index];
              return ListTile(
                tileColor: Colors.purple[100],
                leading: Icon(
                  Icons.list_alt_rounded,
                  color: Colors.blueGrey,
                ),
                title: Text(
                  list["title"],
                  style: TextStyle(color: Colors.deepPurple),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AreYouSureDialog(list: list),
                    );
                  },
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
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 10,
                color: Colors.pink[100],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: Icon(Icons.add_box_outlined),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ListTitlePage()));
        },
      ),
    );
  }
}
