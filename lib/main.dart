import 'package:flutter/material.dart';
import 'package:flutter_news_reader/application/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  runApp(const ProviderScope(child: NewsReader()));
}
