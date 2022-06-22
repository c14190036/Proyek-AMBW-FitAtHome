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
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              padding: EdgeInsets.all(16),
              child: Image.asset('assets/logofitathomev2.png', height: 100)),
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
                onPressed: () {},
                child: Text("START")),
          ),
        ],
      ),
    );
  }
}
