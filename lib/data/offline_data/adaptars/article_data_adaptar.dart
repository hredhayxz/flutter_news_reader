import 'dart:convert';

import 'package:flutter_news_reader/data/models/news_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ArticlesDataAdapter extends TypeAdapter<ArticlesData> {
  @override
  final typeId = 0;

  @override
  ArticlesData read(BinaryReader reader) {
    try {
      final Map<String, dynamic> json = jsonDecode(reader.read());
      return ArticlesData.fromJson(json);
    } catch (error) {
      print('Error in read: $error');
      return ArticlesData();
    }
  }

  @override
  void write(BinaryWriter writer, ArticlesData obj) {
    try {
      final jsonStr = jsonEncode(obj.toJson());
      writer.write(jsonStr);
    } catch (error) {
      print('Error in write: $error');
    }
  }
}
