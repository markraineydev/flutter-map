import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:maps_test/model/data_model.dart';

class AddDataAlert extends StatefulWidget {
  AddDataAlert({this.model, Key? key}) : super(key: key);

  DataModel? model;

  @override
  State<AddDataAlert> createState() => _AddDataAlertState();
}

class _AddDataAlertState extends State<AddDataAlert> {
  var name = TextEditingController();

  var email = TextEditingController();

  @override
  void initState() {
    if(widget.model != null){
      name.text = widget.model?.name ?? "";
      email.text = widget.model?.email ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: name,
          decoration: const InputDecoration(
            hintText: "Name",
          ),
        ),
        TextField(
          controller: email,
          decoration: const InputDecoration(
            hintText: "Email",
          ),
        ),

        ElevatedButton(
          onPressed: (){
            if(name.text.trim().isEmpty){
              createSnackBar("Please enter name");
            }else if(email.text.trim().isEmpty){
              createSnackBar("Please enter email");
            }else{
              var ref = FirebaseFirestore.instance.collection("Data").doc(widget.model == null ? null : widget.model!.id);
              var m = DataModel(name.text, email.text);
              ref.set(m.toMap());
              Navigator.of(context).pop();
            }

          },
          child: Text(widget.model == null ? "Add" : "Update"),
        ),
      ],
    );
  }

  void createSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message),
        backgroundColor: Colors.red);

    // Find the Scaffold in the Widget tree and use it to show a SnackBar!
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
