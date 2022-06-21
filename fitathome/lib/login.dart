import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fitathome/firebase_options.dart';
import 'package:fitathome/home.dart';
import 'package:fitathome/main.dart';
import 'package:fitathome/register.dart';



class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  @override
  void dispose() {
    controllerPassword.dispose();
    controllerEmail.dispose();

    super.dispose();
  }

  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    //checkUser(auth);

    super.initState();
  }

  
  final formKey = GlobalKey<FormState>();

  var passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                child: Image.asset('assets/logofitathomev2.png')
              ),
              
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextFormField(
                  controller: controllerEmail,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: "Masukkan Email"
                  ),
                  validator: (value) {
                      if (value!.isEmpty) {
                        return ("Email tidak boleh kosong!");
                      }
                    },
                ),
              ),
              
              Container(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: TextFormField(
                  controller: controllerPassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.vpn_key),
                    labelText: "Masukkan Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisibility
                        ? Icons.visibility_off
                        : Icons.visibility,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        setState(() {
                          passwordVisibility = !passwordVisibility;
                        });
                      },
                    )
                  ),
                  obscureText: passwordVisibility,
                  validator: (value) {
                      if (value!.isEmpty) {
                        return ("Password tidak boleh kosong!");
                      }
                    },
                ),
              ),
              
              Container(
                child: ElevatedButton(
                  onPressed: () {signin(controllerEmail.text.toString(), controllerPassword.text.toString());},
                  child: Text("Login")),
              ),
              
              Container(
                padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Column(
                  children: [
                    Text("Belum punya akun ?"),
                    TextButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                    }, child: Text("REGISTER"))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signin (String email, String pass) async {
    if (formKey.currentState!.validate()) {
      await auth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((value) => {
          SnackBar(content: Text("Login sukses")),
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()))
      });
    }
    
  }

  void checkUser(FirebaseAuth authentication) {
    var user = authentication.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
    }
  }
}