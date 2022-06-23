import 'package:c14190016_01/firestoreService.dart';
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
            return Text('Error');
          }
          else if (snapshot.hasData || snapshot.data != null) {
            return ListView.separated(
              itemBuilder: (context, index) {
                DocumentSnapshot dsData = snapshot.data!.docs[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(dsData['tumbnail']),
                  ),
                  title: dsData['title'],
                  subtitle: dsData['description'],
                );
              }, 
              separatorBuilder: (context, index) {
                return Divider();
              }, 
              itemCount: snapshot.data!.docs.length,
            ),
        },
      ),
    );
  }
}