import 'package:flutter_news_reader/data/models/news_model.dart';
import 'package:flutter_news_reader/provider/network_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DataProvider {
  static final articleDataProvider = FutureProvider<List<ArticlesData>>((ref) async =>
      ref.watch(NetworkProvider.networkProvider).getRequest());
}