import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/API_Manager.dart';
import 'package:flutter_app/JSON.dart';
import 'package:flutter_app/ImageScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Unsplash',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<UnsplashPhoto>> _photos;

  @override
  void initState() {
    _photos = APIManager().getPhoto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo'),
      ),
      body: FutureBuilder(
        future: _photos,
        builder: (BuildContext context, AsyncSnapshot<List<UnsplashPhoto>> snapshot) {
          if (snapshot.hasData) {
            List<UnsplashPhoto> photos = snapshot.data;
            return Container (
              child: ListView(
              children: photos.map((UnsplashPhoto photo) => InkWell(child:Container(
                width: MediaQuery.of(context).size.width * 0.94,
                child: Card(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.35,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(photo.urls.thumb),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[Container(
                              width: MediaQuery.of(context).size.width * 0.64,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Text(
                                  photo.description ?? photo.altDescription ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18,),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.64,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Text(
                                  'Author: ' + photo.user.name ?? '',
                                  style: TextStyle(fontSize: 12,),
                                ),
                              ),
                            ),
                          ],
                        )
                      ]
                  ),
                ),
              ),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImageScreen(imageUrl: photo.urls.regular, title: photo.description ?? photo.altDescription ?? '',),),
                ),
              ),
              ).toList(),
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }}