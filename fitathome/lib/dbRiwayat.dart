import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference tbCatatan = FirebaseFirestore.instance.collection("tbHistory");

class DatabaseRiwayat {
  static Stream<QuerySnapshot> getData(String email) {

    return tbCatatan
      .where("email", isEqualTo: email)
      .snapshots();
    
    /*if (judul == "") {
      return tbCatatan.snapshots();
    } else {
      return tbCatatan
        .where("judul", isEqualTo: judul)
        .snapshots();
    }*/
    
  }

  /*static Future<void> tambahData({required itemCatatan item}) async {
    DocumentReference docRef = tbCatatan.doc(item.itemJudul);

    await docRef
      .set(item.toJson())
      .whenComplete(() => print("Data berhasil diinput"))
      .catchError((e) => print(e));
  }

  static Future<void> ubahData({required itemCatatan item}) async {
    DocumentReference docRef = tbCatatan.doc(item.itemJudul);

    await docRef
      .update(item.toJson())
      .whenComplete(() => print("data berhasil di ubah"))
      .catchError((e) => print(e));
  }

  static Future<void> hapusData({required String judulhapus}) async {
    DocumentReference docRef = tbCatatan.doc(judulhapus);

    await docRef
      .delete()
      .whenComplete(() => print("Data berhasil dihapus"))
      .catchError((e) => print(e));
  }*/
}