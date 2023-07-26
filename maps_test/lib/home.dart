import 'package:flutter/material.dart';
import 'package:maps_test/map_screen.dart';

import 'firebase_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> MapScreen()));
              },
              child: Text("Map"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> FirebaseScreen()));
              },
              child: Text("Firebase"),
            ),
          ],
        ),
      ),
    );
  }
}
