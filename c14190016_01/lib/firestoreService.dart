import 'package:c14190016_01/dataClass.dart';


class FirestoreDatabase {
  static CollectionReference tbFavorite =
      FirebaseFirestore.instance.collection('tbFavorite');

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

  static Future<void> deleteData({required Consumer consumer}) async {
    DocumentReference doc = tbConsumer.doc(consumer.email);

    await doc
        .delete()
        .whenComplete(() => print('Data Favorite Berhasil di Delete'))
        .catchError((e) => print(e));
  }

}