import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  bool success;
  dynamic message;
  Data data;

  News({
    required this.success,
    required this.message,
    required this.data,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      success: json["success"],
      message: json["message"],
      data: Data.fromJson(json["data"]),
    );
  }
}

class Data {
  String link;
  String description;
  String title;
  String image;
  List<Post> posts;

  Data(
      {required this.link,
      required this.description,
      required this.title,
      required this.image,
      required this.posts});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      link: json['link'],
      description: json['description'],
      title: json['title'],
      image: json['image'],
      posts: List<Post>.from(json['posts'].map((x) => Post.fromJson(x))),
    );
  }
}

class Post {
  String link;
  String title;
  String pubDate;
  String description;
  String thumbnail;

  Post({
    required this.link,
    required this.title,
    required this.pubDate,
    required this.description,
    required this.thumbnail,
  });

  Map<String, dynamic> toJson() {
    return {
      "link": link,
      "title": title,
      "pubDate": pubDate,
      "description": description,
      "thumbnail": thumbnail,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      link: json['link'],
      title: json['title'],
      pubDate: json['pubDate'],
      description: json['description'],
      thumbnail: json['thumbnail'],
    );
  }

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      link: doc.get('link'),
      title: doc.get('title'),
      pubDate: doc.get('pubDate'),
      description: doc.get('description'),
      thumbnail: doc.get('thumbnail'),
    );
  }
}
