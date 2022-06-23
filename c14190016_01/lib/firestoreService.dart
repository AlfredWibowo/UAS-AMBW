import 'package:c14190016_01/dataClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FirestoreDatabase {
  static CollectionReference tbFavorite =
      FirebaseFirestore.instance.collection('tbFavorite');

  static Stream<QuerySnapshot> getData() {
    return tbFavorite.snapshots();
  }

  static Future<void> addData({required Post post}) async {
    DocumentReference doc = tbFavorite.doc(post.title);
    await doc
        .set(post.toJson())
        .whenComplete(() => print('Data Favorite Berhasil di Add'))
        .catchError((e) => print(e));
  }

  static Future<void> editData({required Post post}) async {
    DocumentReference doc = tbFavorite.doc(post.title);

    await doc
        .update(post.toJson())
        .whenComplete(() => print('Data Favorite Berhasil di Update'))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData({required Post post}) async {
    DocumentReference doc = tbFavorite.doc(post.title);

    await doc
        .delete()
        .whenComplete(() => print('Data Favorite Berhasil di Delete'))
        .catchError((e) => print(e));
  }

}