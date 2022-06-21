import 'package:firebase_core/firebase_core.dart';
import 'package:fitathome/home.dart';
import 'package:fitathome/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  runApp(
    MaterialApp(
      title: "Fit At Home",
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return Login();
          }
      })
    );
  }
}
