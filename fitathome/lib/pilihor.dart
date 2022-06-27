import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitathome/dcOlahraga.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

enum WidgetMarker { piliholahraga, backup, jumpingjack, plank, pushup, situp }

class PilihOlahraga extends StatefulWidget {
  const PilihOlahraga({Key? key}) : super(key: key);

  @override
  State<PilihOlahraga> createState() => _PilihOlahragaState();
}

class _PilihOlahragaState extends State<PilihOlahraga> {
  final auth = FirebaseAuth.instance;

  FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> nama = [];
  List<String> gambar = [];

  @override
  void initState() {
    super.initState();
    initControllerBackUp();
    initControllerJumpingJack();
    initControllerPlank();
    initControllerPushUp();
    initControllerSitUp();
    getTImer();
  }

  void initControllerBackUp() {
    _controllerYoutubeBackup = YoutubePlayerController(
        initialVideoId: "Di7TxwrWdho",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        ));
  }

  void initControllerJumpingJack() {
    _controllerYoutubeJumpingJack = YoutubePlayerController(
        initialVideoId: "nnC7FWBM8ZI",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        ));
  }

  void initControllerPlank() {
    _controllerYoutubePlank = YoutubePlayerController(
        initialVideoId: "hsfK3EXN5_M",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        ));
  }

  void initControllerPushUp() {
    _controllerYoutubePushUp = YoutubePlayerController(
        initialVideoId: "gchoWArHXv0",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        ));
  }

  void initControllerSitUp() {
    _controllerYoutubeSitUp = YoutubePlayerController(
        initialVideoId: "6eJVLbgxbBE",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        ));
  }

  @override
  void dispose() {
    _controllerYoutubeBackup.dispose();
    _controllerYoutubeJumpingJack.dispose();
    _controllerYoutubePlank.dispose();
    _controllerYoutubePushUp.dispose();
    _controllerYoutubeSitUp.dispose();

    super.dispose();
  }

  /*@override
  void deactivate() {
    _controllerYoutubeBackup.pause();
    _controllerYoutubeJumpingJack.pause();
    _controllerYoutubePlank.pause();
    _controllerYoutubePushUp.pause();
    _controllerYoutubeSitUp.pause();

    super.deactivate();
  }*/

  int checker = 0;

  var index = 0;

  WidgetMarker selectedWidgetMarker = WidgetMarker.piliholahraga;

  String? _dropdownValue = "Pilih Olahraga";

  String or = "";

  void callback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;

        if (selectedValue == "Pilih Olahraga") {
          selectedWidgetMarker = WidgetMarker.piliholahraga;
        } else if (selectedValue == "Back Up") {
          selectedWidgetMarker = WidgetMarker.backup;
          or = "Back Up";
        } else if (selectedValue == "Jumping Jack") {
          selectedWidgetMarker = WidgetMarker.jumpingjack;
          or = "Jumping Jack";
        } else if (selectedValue == "Plank") {
          selectedWidgetMarker = WidgetMarker.plank;
          or = "Plank";
        } else if (selectedValue == "Push Up") {
          selectedWidgetMarker = WidgetMarker.pushup;
          or = "Push Up";
        } else if (selectedValue == "Sit Up") {
          selectedWidgetMarker = WidgetMarker.situp;
          or = "Sit Up";
        }
      });
    }
  }

  late Timer _timer;
  late int _start;

  void getTImer() async {
    var user = auth.currentUser;
    var uid = user?.uid;

    var bmi = "";

    // var collection = FirebaseFirestore.instance
    //     .collection('tbUser')
    //     .where("email", isEqualTo: email);
    // var querySnapshot = await collection.get();
    // for (var queryDocumentSnapshot in querySnapshot.docs) {
    //   Map<String, dynamic> data = queryDocumentSnapshot.data();
    //   bmi = data['bmi'];
    // }

    CollectionReference coll = FirebaseFirestore.instance.collection("tbUser");

    DocumentSnapshot ds = await coll.doc(uid).get();
    var data = ds.data() as Map<String, dynamic>;

    bmi = await data['bmi'];

    print(await bmi);

    if (bmi == "Normal") {
      _start = 10;
    } else if (bmi == "Underweight") {
      _start = 5;
    } else if (bmi == "Overweight") {
      _start = 15;
    } else if (bmi == "Obese") {
      _start = 20;
    } else {
      _start = 3;
    }
  }

  final _audio = AssetsAudioPlayer();

  String date = DateFormat.yMMMEd().format(DateTime.now());
  String time = DateFormat.jm().format(DateTime.now());

  void startTimer() {
    const oneSecond = const Duration(seconds: 1);
    var firestore = FirebaseFirestore.instance;
    var user = auth.currentUser;
    var random = Random();
    int rand = random.nextInt(100) + 10;

    _timer = Timer.periodic(oneSecond, (Timer timer) {
      if (_start == 0) {
        setState(() async {
          _audio.open(Audio("assets/audio/ringing.mp3"));
          _audio.play();
          timer.cancel();
          dcOlahraga addData = dcOlahraga();
          addData.email = user!.email;
          addData.durasi = 10.toString();
          addData.kalori = rand.toString();
          addData.tanggal = date;
          addData.jam = time;
          addData.olahraga = or;

          await firestore.collection("tbHistory").doc().set(addData.toJson());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Data olahraga kamu berhasil ditambah"),
          ));

          _start = 10;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff00264d),
          title: Text("Pilih Olahraga"),
        ),
        body: Column(
          children: <Widget>[
            Container(
                color: Color(0xff6bc5c5),
                margin: EdgeInsets.all(16),
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: DropdownButton(
                      style: TextStyle(color: Colors.black),
                      isExpanded: true,
                      items: const [
                        DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Pilih Olahraga"),
                          ),
                          value: "Pilih Olahraga",
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Back Up"),
                          ),
                          value: "Back Up",
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Jumping Jack"),
                          ),
                          value: "Jumping Jack",
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Plank"),
                          ),
                          value: "Plank",
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Push Up"),
                          ),
                          value: "Push Up",
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text("Sit Up"),
                          ),
                          value: "Sit Up",
                        )
                      ],
                      value: _dropdownValue,
                      onChanged: callback),
                )),
            customContainer(),
          ],
        ));
  }

  Widget customContainer() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.piliholahraga:
        return pilihContainer();
      case WidgetMarker.backup:
        return backupContainer();
      case WidgetMarker.jumpingjack:
        return jumpingjackContainer();
      case WidgetMarker.plank:
        return plankContainer();
      case WidgetMarker.pushup:
        return pushupContainer();
      case WidgetMarker.situp:
        return situpContainer();
    }
  }

  late YoutubePlayerController _controllerYoutubeBackup;
  late YoutubePlayerController _controllerYoutubeJumpingJack;
  late YoutubePlayerController _controllerYoutubePlank;
  late YoutubePlayerController _controllerYoutubePushUp;
  late YoutubePlayerController _controllerYoutubeSitUp;

  Widget pilihContainer() {
    checker = 0;

    return Container(
      child: Text("Pilih ya"),
    );
  }

  Widget backupContainer() {
    return Column(
      children: [
        Container(child: Text("")),
        Container(
          padding: EdgeInsets.all(16),
          child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controllerYoutubeBackup,
                showVideoProgressIndicator: true,
              ),
              builder: (context, playerbackup) {
                return playerbackup;
              }),
        ),
        Container(
          height: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text(
                    "${_start} detik",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Container(
                    child: ElevatedButton(
                  onPressed: () {
                    startTimer();
                  },
                  child: Text("Start Timer",
                      style: TextStyle(color: Colors.black)),
                )),
              ]),
        )
      ],
    );
  }

  Widget jumpingjackContainer() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controllerYoutubeJumpingJack,
                showVideoProgressIndicator: true,
              ),
              builder: (context, playerjumpingjack) {
                return playerjumpingjack;
              }),
        ),
        Container(
          height: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text(
                    "${_start} detik",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Container(
                    child: ElevatedButton(
                  onPressed: () {
                    startTimer();
                  },
                  child: Text("Start Timer",
                      style: TextStyle(color: Colors.black)),
                )),
              ]),
        )
      ],
    );
  }

  Widget plankContainer() {
    return Column(
      children: [
        Container(
          child: Row(
            children: [Text("")],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controllerYoutubePlank,
                showVideoProgressIndicator: true,
              ),
              builder: (context, player) {
                return player;
              }),
        ),
        Container(
          height: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text(
                    "${_start} detik",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Container(
                    child: ElevatedButton(
                  onPressed: () {
                    startTimer();
                  },
                  child: Text("Start Timer",
                      style: TextStyle(color: Colors.black)),
                )),
              ]),
        )
      ],
    );
  }

  Widget pushupContainer() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          child: YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controllerYoutubePushUp,
                showVideoProgressIndicator: true,
              ),
              builder: (context, player) {
                return player;
              }),
        ),
        Container(
          height: 200,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Text(
                    "${_start} detik",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                Container(
                    child: ElevatedButton(
                  onPressed: () {
                    startTimer();
                  },
                  child: Text("Start Timer",
                      style: TextStyle(color: Colors.black)),
                )),
              ]),
        )
      ],
    );
  }

  Widget situpContainer() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          YoutubePlayerBuilder(
              player: YoutubePlayer(
                controller: _controllerYoutubeSitUp,
                showVideoProgressIndicator: true,
              ),
              builder: (context, player) {
                return player;
              }),
          Container(
            height: 200,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Text(
                      "${_start} detik",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  Container(
                      child: ElevatedButton(
                    onPressed: () {
                      startTimer();
                    },
                    child: Text("Start Timer",
                        style: TextStyle(color: Colors.black)),
                  )),
                ]),
          )
        ],
      ),
    );
  }
}
