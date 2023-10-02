import 'package:flutter/material.dart';
import 'package:flutter_news_reader/presentation/ui/screens/splash_screen.dart';

class NewsReader extends StatelessWidget {
  const NewsReader({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
