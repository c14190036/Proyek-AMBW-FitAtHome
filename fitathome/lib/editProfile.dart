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
                  child: Text(
                    "Edit Profilemu",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    controller: _inputNamaController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        prefixIcon: const Icon(Icons.person),
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
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    controller: _inputBeratController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixIcon: const Icon(Icons.monitor_weight_rounded),
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
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    controller: _inputTinggiController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        prefixIcon: const Icon(Icons.height_rounded),
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
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      editProfile(
                          _inputNamaController.text.toString(),
                          _inputBeratController.text.toString(),
                          _inputTinggiController.text.toString());
                    },
                    child: Text("UPDATE PROFILE"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void editProfile(String nama_, String berat_, String tinggi_) async {
    var firestore = FirebaseFirestore.instance;
    var user = auth.currentUser;
    if (formKey.currentState!.validate()) {
      dcProfile update = dcProfile();
      update.email = user!.email;
      update.nama = nama_;
      update.berat = berat_;
      update.tinggi = tinggi_;
      await firestore.collection('tbUser').doc(user.uid).set(update.toJson());
      Navigator.pop(context);
    }
  }
}
