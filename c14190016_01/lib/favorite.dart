// ignore_for_file: prefer_const_constructors

import 'package:c14190016_01/dataClass.dart';
import 'package:c14190016_01/detail.dart';
import 'package:c14190016_01/firestoreService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreDatabase.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (snapshot.hasData || snapshot.data != null) {
            return ListView.separated(
              itemBuilder: (context, index) {
                DocumentSnapshot dsData = snapshot.data!.docs[index];
                Post post = Post.fromDocument(dsData);

                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(post.thumbnail),
                    ),
                    title: Text(post.title),
                    subtitle: Text(post.description),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(dataPost: post)));
                    },
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: snapshot.data!.docs.length,
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
