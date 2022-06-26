import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fitathome/dcProfile.dart';
import 'package:fitathome/main.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();

    super.dispose();
  }

  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  var passwordVisibility = true;
  var passwordConfirmVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  child: Image.asset('assets/logofitathomev2.png',height: 100)
                ),
                Container(
                  child: Text("Register", style: TextStyle(fontSize: 20),),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: namaController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Color(0xff6bc5c5),),
                      border: OutlineInputBorder(),
                      labelText: "Nama"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Nama tidak boleh kosong!");
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: const Icon(Icons.email_outlined, color: Color(0xff6bc5c5),),
                      border: OutlineInputBorder(),
                      labelText: "Email"
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Email tidak boleh kosong!");
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    obscureText: passwordConfirmVisibility,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.vpn_key, color: Color(0xff6bc5c5),),
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordConfirmVisibility
                          ? Icons.visibility_off
                          : Icons.visibility,
                          color: Color(0xff6bc5c5),
                        ),
                        onPressed: () {
                          setState(() {
                            passwordConfirmVisibility = !passwordConfirmVisibility;
                          });
                        },
                      )
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Password tidak boleh kosong!");
                      }
                      if (value.length < 6) {
                        return("min. character password adalah 6");
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: confirmpasswordController,
                    keyboardType: TextInputType.number,
                    obscureText: passwordVisibility,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.vpn_key, color: Color(0xff6bc5c5),),
                      border: OutlineInputBorder(),
                      labelText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisibility
                          ? Icons.visibility_off
                          : Icons.visibility,
                          color: Color(0xff6bc5c5),
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        },
                      )
                    ),
                    validator: (value) {
                      if (value != passwordController.text) {
                        return("Password tidak sama!");
                      }
                      if (value!.isEmpty) {
                        return("Tidak boleh kosong!");
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  child: ElevatedButton(
                    onPressed: () {register(emailController.text.toString(), passwordController.text.toString());},
                    child: Text("REGISTER")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register(String email, String pass) async {
    if(formKey.currentState!.validate()) {
        await auth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((value) => addData())
        .catchError((e) {
          SnackBar(content: Text("${e.message}"));
      });
    }
    
  }

  addData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    dcProfile profile = dcProfile();

    profile.email = user!.email;
    profile.nama = namaController.text;

    await firestore
      .collection("tbUser")
      .doc(user.uid)
      .set(profile.toJson());
    SnackBar(content: Text("Akun telah dibuat"));

    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
  }
}