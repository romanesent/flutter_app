import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String title;
  final String imageUrl;

  ImageScreen({this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(title),
      ),
      body:Center(
        child: Image.network(
          imageUrl,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}