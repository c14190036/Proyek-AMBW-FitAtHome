import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';

void main() {
  runApp(const alarm());
}

class alarm extends StatefulWidget {
  const alarm({Key? key}) : super(key: key);

  @override
  State<alarm> createState() => _alarmState();
}

class _alarmState extends State<alarm> {
  TextEditingController jamController = TextEditingController();
  TextEditingController menitController = TextEditingController();
  int jam = 0;
  int menit = 0;
  TimeOfDay _time = TimeOfDay.now();
  late TimeOfDay picked;

  Future<Null> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
    ))!;
    setState(() {
      _time = picked;
      String j = _time.hour.toString();
      String m = _time.minute.toString();
      jam = int.parse(j);
      menit = int.parse(m);
      print(picked);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00264d),
        title: Text("Reminder Olahraga"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.all(16),
                    child: Image.asset('assets/picforalarm.png')),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Alarm Reminder Olahraga akan membantumu untuk olahraga secara rutin setiap hari.",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 300,
                  padding: EdgeInsets.only(top: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      selectTime(context);
                    },
                    child: Text(
                      "Atur Alarm",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 16),
                  width: 300,
                  child: ElevatedButton(
                    child: Text(
                      'Aktifkan Alarm',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    onPressed: () {
                      FlutterAlarmClock.createAlarm(jam, menit,
                          title: "Waktunya Olahraga");
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
