import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

enum WidgetMarker {
  piliholahraga, backup, jumpingjack, plank, pushup, situp
}

class PilihOlahraga extends StatefulWidget {
  const PilihOlahraga({ Key? key }) : super(key: key);

  @override
  State<PilihOlahraga> createState() => _PilihOlahragaState();
}

class _PilihOlahragaState extends State<PilihOlahraga> {

  final auth = FirebaseAuth.instance;

  List<String> nama = [];
  List<String> gambar = [];

  @override
  void initState() {
    super.initState();
  }

  /*@override
  void dispose() {
    // _controllerYoutubeBackup.dispose();
    // _controllerYoutubeJumpingJack.dispose();
    // _controllerYoutubePlank.dispose();
    // _controllerYoutubePushUp.dispose();
    // _controllerYoutubeSitUp.dispose();

    super.dispose();
  }*/

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

  void callback (String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;

        if (selectedValue == "Pilih Olahraga") {
          selectedWidgetMarker = WidgetMarker.piliholahraga;
        } else if (selectedValue == "Back Up") {
          selectedWidgetMarker = WidgetMarker.backup;
        } else if (selectedValue == "Jumping Jack") {
          selectedWidgetMarker = WidgetMarker.jumpingjack;
        }  else if (selectedValue == "Plank") {
          selectedWidgetMarker = WidgetMarker.plank;
        } else if (selectedValue == "Push Up") {
          selectedWidgetMarker = WidgetMarker.pushup;
        } else if (selectedValue == "Sit Up") {
          selectedWidgetMarker = WidgetMarker.situp;
        }
      });
    }
  }

  late Timer _timer;
  int _start = 10;

  @override
  Widget build(BuildContext context) {

    final _audio = AssetsAudioPlayer();
    
    void startTimer() {
      const oneSecond = const Duration(seconds: 1);
      _timer = Timer.periodic(
          oneSecond,
          (Timer timer) {
            if (_start == 0) {
              setState(() {
                _audio.open(
                  Audio("assets/audio/ringing.mp3")
                );
                _audio.play();
                timer.cancel();
                _start = 10;
              });
            } else {
              setState(() {
                _start--;
              });
            }
          }
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Pilih Olahraga"),
      ),

      body: Column(
        children: <Widget> [
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: DropdownButton(
              isExpanded: true,
              items: const [
                DropdownMenuItem(child: Text("Pilih Olahraga"), value: "Pilih Olahraga",),
                DropdownMenuItem(child: Text("Back Up"), value: "Back Up",),
                DropdownMenuItem(child: Text("Jumping Jack"), value: "Jumping Jack",),
                DropdownMenuItem(child: Text("Plank"), value: "Plank",),
                DropdownMenuItem(child: Text("Push Up"), value: "Push Up",),
                DropdownMenuItem(child: Text("Sit Up"), value: "Sit Up",)
              ],
              value: _dropdownValue,
              onChanged: callback
            )
          ),
          customContainer(),
          Container(
            child: ElevatedButton(
              onPressed: () {
                startTimer();
              },
              child: Text("Start Timer"),
            )
          ),
          Container(
            child: Text("${_start} detik"),
          )
        ],
      )
    );
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
    checker = 1;
    
    //_controllerYoutubeBackup
    _controllerYoutubeBackup = YoutubePlayerController(
        initialVideoId: "hnTuuGU50cs",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        )
      );

    return Column(
      children: [
        Container(child: Text("Back Up Ini")),
        Container(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controllerYoutubeBackup,
              showVideoProgressIndicator: true,
            ),
            builder: (context, playerbackup) {
              return playerbackup;
            }
          ),
        ),
      ],
    );
  }

  Widget jumpingjackContainer() {
    
    _controllerYoutubeJumpingJack = YoutubePlayerController(
        initialVideoId: "kRdnkN_P7WU",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        )
      );

    return Column(
      children: [
        Container(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controllerYoutubeJumpingJack,
              showVideoProgressIndicator: true,
            ),
            builder: (context, playerjumpingjack) {
              return playerjumpingjack;
            }
          ),
        ),
      ],
    );
  }

  Widget plankContainer() {
    checker = 3;
    
    //_controllerYoutubePlank
    _controllerYoutubePlank = YoutubePlayerController(
        initialVideoId: "hnTuuGU50cs",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        )
      );
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Text("Ini Plank")
            ],
          ),
        ),
        Container(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controllerYoutubePlank,
              showVideoProgressIndicator: true,
            ),
            builder: (context, player) {
              return player;
            }
          ),
        ),
      ],
    );
  }

  Widget pushupContainer() {
    checker = 4;
    

    //_controllerYoutubePushUp
    _controllerYoutubePushUp = YoutubePlayerController(
        initialVideoId: "kRdnkN_P7WU",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        )
      );
    return Column(
      children: [
        Container(
          child: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controllerYoutubePushUp,
              showVideoProgressIndicator: true,
            ),
            builder: (context, player) {
              return player;
            }
          ),
        ),
      ],
    );
  }

  Widget situpContainer() {
    checker = 5;
    
    //_controllerYoutubeSitUp
    _controllerYoutubeSitUp = YoutubePlayerController(
        initialVideoId: "hnTuuGU50cs",
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
        )
      );
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controllerYoutubeSitUp,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return player;
      }
    );
  }
}

class Model {
  String nama;
  String gambar;
  bool check;

  Model(this.nama, this.gambar, this.check);

  String getNama() {
    return nama;
  }

  String getGambar() {
    return gambar;
  }

  bool isChecked() {
    return check;
  }
}