import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference tbCatatan = FirebaseFirestore.instance.collection("tbHistory");

class DatabaseRiwayat {
  static Stream<QuerySnapshot> getData(String email) {

    return tbCatatan
      .where("email", isEqualTo: email)
      .snapshots();
  }
}