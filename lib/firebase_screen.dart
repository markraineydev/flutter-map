import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maps_test/alert/add_data_alert.dart';
import 'package:maps_test/model/data_model.dart';

class FirebaseScreen extends StatefulWidget {
  @override
  State<FirebaseScreen> createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  var ref = FirebaseFirestore.instance.collection("Data");

  List<DataModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          AlertDialog dialog = AlertDialog(
            content: AddDataAlert(),
          );
          showDialog(context: context, builder: (_) => dialog);
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: ref.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else {
              if (snapshot.data!.size == 0) {
                return const Center(
                  child: Text("No data found"),
                );
              }

              list = List.generate(snapshot.data!.docs.length, (index) {
                var doc = snapshot.data!.docs[index];
                var data = doc.data();
                var model = DataModel.fromMap(data);
                model.id = doc.id;
                return model;
              });
              return ListView.builder(
                itemBuilder: (ctx, i) {
                  return dataWidget(list[i]);
                },
                itemCount: list.length,
              );
            }
          }),
    );
  }

  Widget dataWidget(DataModel model) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    model.email,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                ref.doc(model.id).delete();
              },
              icon: const Icon(Icons.delete),
            ),
            IconButton(
              onPressed: () {
                AlertDialog dialog = AlertDialog(
                  content: AddDataAlert(model: model,),
                );
                showDialog(context: context, builder: (_) => dialog);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
      ),
    );
  }
}
