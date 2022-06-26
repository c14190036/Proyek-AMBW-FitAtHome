import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fitathome/dcProfile.dart';
import 'package:fitathome/home.dart';

class editProfile extends StatefulWidget {
  const editProfile({Key? key}) : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final _inputNamaController = TextEditingController();
  final _inputBeratController = TextEditingController();
  final _inputTinggiController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _inputNamaController.dispose();
    _inputBeratController.dispose();
    _inputTinggiController.dispose();

    super.dispose();
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00264d),
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _inputNamaController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        prefixIcon: const Icon(Icons.person, color: Colors.white,),
                        border: OutlineInputBorder(),
                        labelText: "Masukan Nama"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Nama Tidak Boleh Kosong!");
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _inputBeratController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixIcon: const Icon(Icons.monitor_weight_rounded, color: Colors.white,),
                        border: OutlineInputBorder(),
                        labelText: "Masukan Berat Badan"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Berat Badan Tidak Boleh Kosong");
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: _inputTinggiController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixIcon: const Icon(Icons.height_rounded, color: Colors.white,),
                        border: OutlineInputBorder(),
                        labelText: "Masukan Tinggi Badan"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Tinggi Badan Tidak Boleh Kosong");
                      }
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff00264d)
                    ),
                    onPressed: () {
                      editProfile(
                          _inputNamaController.text.toString(),
                          _inputBeratController.text.toString(),
                          _inputTinggiController.text.toString());
                    },
                    child: Text("UPDATE"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _bmi = "";
  String _bmiskor = "";

  void calculate_bmi (String berat, String tinggi) {
    double b = double.parse(berat);
    double t = double.parse(tinggi) / 100;

    double bbmi = b / (pow(t, 2));

    _bmiskor = bbmi.toStringAsFixed(2);

    if (bbmi < 18.5) {
      _bmi = "Underweight";
    } else if (bbmi >= 18.5 && bbmi <= 24.9) {
      _bmi = "Normal";
    } else if (bbmi >= 25 && bbmi <= 29.9) {
      _bmi = "Overweight";
    } else if (bbmi >= 30) {
      _bmi = "Obese";
    }
  }

  void editProfile(String nama_, String berat_, String tinggi_) async {
    var firestore = FirebaseFirestore.instance;
    var user = auth.currentUser;
    if (formKey.currentState!.validate()) {
      dcProfile update = dcProfile();
      calculate_bmi(berat_, tinggi_);
      update.email = user!.email;
      update.nama = nama_;
      update.berat = berat_;
      update.tinggi = tinggi_;
      update.bmi = _bmi;
      update.bmiskor = _bmiskor;
      await firestore.collection('tbUser').doc(user.uid).set(update.toJson());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Berhasil Edit Data"),
      ));
      Navigator.pop(context);
      //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
  }
}