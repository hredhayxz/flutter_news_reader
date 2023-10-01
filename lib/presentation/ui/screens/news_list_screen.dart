import 'package:flutter/material.dart';
import 'package:flutter_news_reader/data/models/news_model.dart';
import 'package:flutter_news_reader/data/offline_data/offline_data_handler.dart';
import 'package:flutter_news_reader/presentation/ui/screens/news_details_screen.dart';
import 'package:flutter_news_reader/presentation/ui/widgets/news_card.dart';
import 'package:flutter_news_reader/provider/data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewsListScreen extends ConsumerWidget {
  const NewsListScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(DataProvider.articleDataProvider);
    List<ArticlesData> articles;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latest News"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          print("Refreshing data...");
          await ref.refresh(DataProvider.articleDataProvider);
          print("Data refreshed!");
        },
        child: data.when(
          data: (data) {
            articles = data.map((e) => e).toList();
            List dataArticle = articles;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailsScreen(
                          article: articles[index],
                        ),
                      ),
                    );
                  },
                  child: NewsCard(
                    article: articles[index],
                  ),
                );
              },
            );
          },
          error: (error, _) => Text(error.toString()),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          creat();
          OfflineDataHandler.hiveData();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void creat() {}
}
