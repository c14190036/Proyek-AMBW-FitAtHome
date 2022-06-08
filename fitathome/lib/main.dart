import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.currentPlatform,
  //);
  //FirebaseAuth auth = FirebaseAuth.instance;
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
  void dispose() {
    _controllerPassword.dispose();
    _controllerEmail.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Image.asset('assets/logofitathomev2.png')
            ),
            
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TextField(
                controller: _controllerEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Masukkan Email"
                ),
              ),
            ),
      
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: TextField(
                controller: _controllerPassword,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Masukkan Password"
                ),
              ),
            ),
            
            Container(
              child: ElevatedButton(onPressed: () {}, child: Text("Login")),
            ),
      
            Container(
              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: Column(
                children: [
                  Text("Belum punya akun ?"),
                  TextButton(onPressed: () {}, child: Text("REGISTER"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
