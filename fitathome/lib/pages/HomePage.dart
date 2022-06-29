import 'dart:async';

import 'package:fitathome/alarm.dart';
import 'package:fitathome/pilihor.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    'assets/pushup.jpg',
    'assets/situp.jpg',
    'assets/backup.jpg',
    'assets/jumpingjack.jpg',
    'assets/plank.jpg'
  ];

  List<String> linkImage = [
    'https://www.alodokter.com/ini-dia-empat-manfaat-push-up',
    'https://www.alodokter.com/perut-terlihat-kencang-berkat-manfaat-sit-up',
    'https://www.lemonilo.com/blog/ketahuilah-5-manfaat-back-up-yang-baik-untuk-tubuh',
    'https://www.kompas.com/sports/read/2022/02/17/22300078/jumping-jack--cara-melakukan-dan-manfaat?page=all',
    'https://www.alodokter.com/memahami-gerakan-dan-manfaat-plank'
  ];

  int _currentIndex = 0;
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
              height: 100,
              width: 200,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Image.asset('assets/logo_v3.png')),
          Container(
            padding: EdgeInsets.all(0),
            child: CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 0.6,
                  autoPlayAnimationDuration: const Duration(milliseconds: 100),
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    _currentIndex = index;
                    setState(() {});
                  }),
              items: images
                  .map((item) => Center(
                          child: GestureDetector(
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                        ),
                        onTap: () async {
                          await launch(linkImage[_currentIndex]);
                        },
                      )))
                  .toList(),
            ),
          ),
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
