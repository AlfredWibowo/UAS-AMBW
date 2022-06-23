// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:c14190016_01/apiServices.dart';
import 'package:c14190016_01/detail.dart';
import 'package:flutter/material.dart';

import 'dataClass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAS AMBW',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  APIServices serviceAPI = APIServices();
  //late Future<List<Data>> _listData;
  late Future<News> _news;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _listData = serviceAPI.getAllData();
    _news = serviceAPI.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search), 
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<News>(
                future: _news,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    News isiData = snapshot.data!;
                    List<Post> listPost = isiData.data.posts;
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        Post post = listPost[index];
            
                        return Card(
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(post.thumbnail),
                            ),
                            title: Text(post.title),
                            subtitle: Text(post.description),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(dataPost: post)));  
                            },
                            trailing: Icon(Icons.arrow_forward_ios),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: listPost.length,
                    );
                  }
            
                  return Center(child: CircularProgressIndicator(),);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
