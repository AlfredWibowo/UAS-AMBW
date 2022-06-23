// ignore_for_file: prefer_const_constructors

import 'package:c14190016_01/dataClass.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Post dataPost;
  const DetailPage({Key? key, required this.dataPost}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Detail Page'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(widget.dataPost.thumbnail),
              ),
              SizedBox(height: 30,),
              ListTile(
                title: Text('Link: '),
                subtitle: Text(widget.dataPost.link)
              ),
              SizedBox(height: 10,),
              ListTile(
                title: Text('Title: '),
                subtitle: Text(widget.dataPost.title)
              ),
              SizedBox(height: 10,),
              ListTile(
                title: Text('Publication Date: '),
                subtitle: Text(widget.dataPost.pubDate)
              ),
              SizedBox(height: 10,),
              ListTile(
                title: Text('Description: '),
                subtitle: Text(widget.dataPost.description)
              ),
            ],
          ),
        ),
      ),
    );
  }
}