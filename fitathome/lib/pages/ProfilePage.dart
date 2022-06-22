import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitathome/login.dart';
import 'package:flutter/material.dart';
import 'package:fitathome/editProfile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  String uid() {
    var user = auth.currentUser;
    var uid = user?.uid;
    return uid!;
  }

  CollectionReference user = FirebaseFirestore.instance.collection('tbUser');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Your Profile"),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                logout();
              },
              child: Icon(
                Icons.logout,
                size: 26,
                color: Colors.red,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: (FutureBuilder(
            future: user.doc(uid()).get(),
            builder: (buildcontext, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(16),
                        child: Image.asset('assets/logofitathomev2.png',
                            height: 120)),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(24, 16, 8, 16),
                          child: Text(
                            "Nama :",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Container(
                          child: Text(
                            '${data['nama']}',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(24, 8, 8, 16),
                          child: Text(
                            "Email :",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                          child: Text('${data['email']}',
                              style: TextStyle(fontSize: 24)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(24, 8, 8, 16),
                          child: Text(
                            "Berat :",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(11, 8, 8, 16),
                          child: Text('${data['berat']}',
                              style: TextStyle(fontSize: 24)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 8, 8, 16),
                          child: Text(
                            "Kg",
                            style: TextStyle(fontSize: 24),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(24, 8, 8, 16),
                          child: Text(
                            "Tinggi :",
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(4, 8, 8, 16),
                          child: Text('${data['tinggi']}',
                              style: TextStyle(fontSize: 24)),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 8, 8, 16),
                          child: Text(
                            "Cm",
                            style: TextStyle(fontSize: 24),
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => editProfile()))
                              .then(onGoBack);
                        },
                        child: Text("Edit Profile"),
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0, 38, 77, 1.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 42, vertical: 6),
                            textStyle: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.lightBlueAccent,
                  ),
                ));
              }
            },
          )),
        ),
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {
      user = FirebaseFirestore.instance.collection('tbUser');
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Berhasil Edit Data"),
    ));
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}
