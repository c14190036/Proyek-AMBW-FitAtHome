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
  double? _bmi;
  String _message = '';

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
        title: Text("Profile"),
        backgroundColor: Color.fromRGBO(0, 38, 77, 1.0),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                logout();
              },
              child: IconButton(
                icon: Icon(Icons.logout, color: Colors.red,),
                onPressed: () {logout();},
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
                void _calculate() {
                  setState(() {});
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        padding: EdgeInsets.all(16),
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(48),
                            child: Image.network('https://ek.polmed.ac.id/wp-content/uploads/sites/7/2020/12/author-1.jpg', fit: BoxFit.cover,),
                          ),
                        )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white),
                        //color: Color(0xff79dddd),
                      ),
                      child: Container(
                        width: 300,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Icon(Icons.person, size: 35,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(data['nama'], style: TextStyle(fontSize: 20),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Container(
                        width: 300,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Icon(Icons.email, size: 35,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text(data['email'], style: TextStyle(fontSize: 20),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Container(
                        width: 300,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Icon(Icons.monitor_weight, size: 35,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text("${data['berat']} kg", style: TextStyle(fontSize: 20),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Container(
                        width: 300,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Icon(Icons.height, size: 35,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text("${data['tinggi']} cm", style: TextStyle(fontSize: 20),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Container(
                        width: 300,
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                              child: Icon(Icons.accessibility, size: 35,),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Text("${data['bmiskor']} (${data['bmi']})", style: TextStyle(fontSize: 20),),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => editProfile())).then(onGoBack);
                        },
                        child: Text("Edit Profile",  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff6bc5c5),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 42, vertical: 6),
                          textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            )
                        ),
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
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}
