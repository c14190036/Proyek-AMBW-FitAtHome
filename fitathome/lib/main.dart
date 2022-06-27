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
  runApp(MaterialApp(
    title: "Fit At Home",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff001934),
        textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xff6bc5c5),
          ),
        ),
        hintColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff6bc5c5))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff6bc5c5))),
          labelStyle: TextStyle(color: Color(0xff6bc5c5)),
        )),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
            }));
  }
}
