import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_app/JSON.dart';

class APIManager {
  final String url = "https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0";

  Future<List<UnsplashPhoto>> getPhoto() async {
    Response res = await get(url);

    if (res.statusCode == 200) {

      List<dynamic> body = jsonDecode(res.body);
      List<UnsplashPhoto> photo = body.map((dynamic item) => UnsplashPhoto.fromJson(item),).toList();

      return photo;
    } else {
      throw "Connection failed";
    }
  }
}
