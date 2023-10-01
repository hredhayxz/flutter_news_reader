import 'package:flutter/material.dart';
import 'package:flutter_news_reader/application/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  runApp(const ProviderScope(child: NewsReader()));
}
