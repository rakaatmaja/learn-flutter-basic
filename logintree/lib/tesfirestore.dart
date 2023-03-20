import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TesFirestore extends StatefulWidget {
  const TesFirestore({Key? key}) : super(key: key);

  @override
  State<TesFirestore> createState() => _TesFirestoreState();
}

class _TesFirestoreState extends State<TesFirestore> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: db.collection('users').snapshots(),
        builder: (_, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshots.hasError) {
            return const Center(
              child: Text('Error'),
            );
          } else {
            final data = snapshots.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, idx) {
                  return ListTile(
                    onLongPress: () {
                      data[idx].reference.delete();

                      db.collection("users").doc().delete().then(
                            (value) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Succes Deleted'), backgroundColor: Colors.red, duration: Duration(seconds: 1),
                              ),
                            ),
                          );
                    },
                    subtitle: Text(data[idx].data()['born'].toString()),
                    title: Text(data[idx].data()['first'] +
                        " " +
                        data[idx].data()['last']),
                  );
                });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final user = <String, dynamic>{
            "first": "Alan",
            "middle": "Mathison",
            "last": "Turing",
            "born": 1912
          };
          db.collection("users").add(user).then((DocumentReference doc) =>
                 ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Add Data'),backgroundColor: Colors.greenAccent,duration: Duration(seconds: 1),
                              ),
                            ),);
          await db.collection("users").get().then((event) {
            for (var doc in event.docs) {
              print("${doc.id} => ${doc.data()}");
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
