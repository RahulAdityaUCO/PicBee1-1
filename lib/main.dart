import 'package:PicBee1/pages/SpashScreen.dart';
import 'package:PicBee1/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
   Firestore.instance.settings(timestampsInSnapshotsEnabled: true).then((_) {
     // print("Timestamps enabled in snapshots\n");
   }, onError: (_) {
     // print("Error enabling timestamps in snapshots\n");
   });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PicBee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.teal,
      ),
      home: SplashScreen(),
    );
  }
}
