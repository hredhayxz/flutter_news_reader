import 'dart:developer';
import 'package:flutter_news_reader/data/models/news_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalDataStorage {
  LocalDataStorage._();

  static Box<ArticlesData>? _dataBox;

  static Future<void> init() async {
    try {
      if (_dataBox == null) {
        await Hive.openBox<ArticlesData>('articlesDataBox');
        _dataBox = await Hive.openBox<ArticlesData>('articlesDataBox');
      }
    } catch (error) {
      log('Error in init: $error');
      rethrow;
    }
  }

  static Future<void> saveArticlesData(List<ArticlesData> articlesData) async {
    try {
      await init();
      await _dataBox?.clear();
      await _dataBox?.addAll(articlesData);
      log('Saved ${articlesData.length} articles to local storage.');
    } catch (error) {
      log('Error in saveArticlesData: $error');
      rethrow;
    }
  }

  static Future<List<ArticlesData>> getArticlesFromDatabase() async {
    try {
      final box = await Hive.openBox<ArticlesData>('articlesDataBox');
      return box.values.toList();
    } catch (error) {
      log('Error in getArticlesFromDatabase: $error');
      return [];
    }
  }

  static Future<void> clearArticlesData() async {
    try {
      await _dataBox?.clear();
      log('Cleared articles data from local storage.');
    } catch (error) {
      log('Error in clearArticlesData: $error');
      rethrow;
    }
  }
}
