import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitathome/dcProfile.dart';

CollectionReference tbCatatan = FirebaseFirestore.instance.collection("tbCatatan");

class Database {
  static Stream<QuerySnapshot> getData() {
    return tbCatatan.snapshots();
  }

  /*static Future<void> tambahData({required dcProfile item}) async {
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