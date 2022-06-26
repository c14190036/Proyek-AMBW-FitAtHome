import 'dart:async';

import 'package:fitathome/alarm.dart';
import 'package:fitathome/pilihor.dart';
import 'package:flutter/material.dart';
//import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00264d),
        title: Text("Home"),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => alarm()))
                    .then(onGoBack);
              },
              child: IconButton(
                icon: Icon(
                  Icons.alarm_add_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => alarm()));
                },
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.all(16),
              child: Image.asset('assets/logo_v3.png')),
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text(
              "Selamat Datang di Fit At Home App",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Text("Klik Start untuk memulai olahraga"),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xff6bc5c5)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => PilihOlahraga()));
                },
                child: Text("START",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
          ),
        ],
      ),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Alarm telah ditambah"),
    ));
  }
}
