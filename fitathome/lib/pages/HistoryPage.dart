import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../dbRiwayat.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int _index = 0;

  FirebaseAuth auth = FirebaseAuth.instance;

  /*@override
  void initState() {

    super.initState();
  }*/

  String getEmail() {
    var user = auth.currentUser;
    var email = user?.email;
    return email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff00264d),
        title: Text("Riwayat"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: DatabaseRiwayat.getData(getEmail()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];
                          String lvOlahraga = data['olahraga'];
                          String lvTanggal = data['tanggal'];
                          String lvKalori = data['kalori'];
                          String lvDurasi = data['durasi'];
                          String lvJam = data['jam'];
                          return Card(
                            color: Color(0xff002245),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.lightBlueAccent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(8),
                              child: ListTile(
                                  onTap: () {},
                                  onLongPress: () {},
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      lvOlahraga,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  subtitle: Container(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("$lvDurasi menit",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Text("$lvKalori kalori",
                                          style:
                                              TextStyle(color: Colors.white)),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text("$lvTanggal\n$lvJam",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  color: Colors.white))
                                        ],
                                      )
                                    ],
                                  ))),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemCount: snapshot.data!.docs.length);
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.lightBlueAccent,
                      ),
                    ));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
