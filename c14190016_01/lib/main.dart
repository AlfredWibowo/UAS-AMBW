// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:c14190016_01/apiServices.dart';
import 'package:c14190016_01/detail.dart';
import 'package:c14190016_01/favorite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dataClass.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        home: const BottomNavigationPage());
  }
}

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _currentIndex = 0;

  List<String> title = ['Home', 'Favorite'];
  String _appBarTitle = "Home";

  final List<Widget> _screens = [HomePage(), FavoritePage()];

  BottomNavigationBarItem bottomNavigationBarItem(Icon icon, String label) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
      _appBarTitle = title[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        iconSize: 30,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          bottomNavigationBarItem(Icon(Icons.home), 'Home'),
          bottomNavigationBarItem(Icon(Icons.favorite), 'Favorite'),
        ],
      ),
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

  String searchBarValue = "";

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
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchBarValue = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<News>(
                future: _news,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    News isiData = snapshot.data!;
                    List<Post> listPost = isiData.data.posts;
                    List<Post> filtered = [];
                    if (searchBarValue == "") {
                      filtered = listPost;
                    } 
                    else {
                      for (var post in listPost) {
                        if (post.title.toLowerCase().contains(searchBarValue.toLowerCase())) {
                          filtered.add(post);
                        }
                      }
                    }

                    return ListView.separated(
                      itemBuilder: (context, index) {
                        Post post = filtered[index];

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
                      itemCount: filtered.length,
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
