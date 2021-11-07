import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_with_provider/services/firestore.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var firestore = FireStoreService();
    return Scaffold(
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
                onTap: () {},
              );
            },
          );
        },
      ),
    );
  }
}
