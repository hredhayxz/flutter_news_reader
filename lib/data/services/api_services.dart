import 'dart:convert';
import 'dart:developer';
import 'package:flutter_news_reader/data/models/news_model.dart';
import 'package:flutter_news_reader/data/utility/urls.dart';
import 'package:http/http.dart';

class ApiServices {
  Future<List<ArticlesData>> getRequest() async {
    Response response = await get(Uri.parse(Urls.getNews));
    log(response.statusCode.toString());
    log(response.body);
    final decodedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final List result = decodedResponse['articles'];
      return result.map(((e) => ArticlesData.fromJson(e))).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}