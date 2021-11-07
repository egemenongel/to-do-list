import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/pages/list_page.dart';
import 'package:to_do_list_with_provider/services/firestore.dart';

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
        stream: firestore.listStorage.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  snapshot.data.docs[index].id,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListPage(
                            // To the list on index
                            ),
                      ));
                },
              );
            },
          );
        },
      ),
    );
  }
}
