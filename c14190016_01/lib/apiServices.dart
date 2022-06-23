import 'dart:convert';

import 'package:c14190016_01/dataClass.dart';
import 'package:http/http.dart' as http;

class APIServices {
  String urlAPI = "https://api-berita-indonesia.vercel.app/cnbc/terbaru/";

  Future<News> getAllData() async {
    final response = await http.get(Uri.parse(urlAPI));

    if (response.statusCode == 200) {
      News jsonResponse = News.fromJson(json.decode(response.body));
      return jsonResponse;
    }
    else {
      throw Exception('Failed to load Data');
    }
  }
}