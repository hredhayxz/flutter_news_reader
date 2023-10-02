import 'package:flutter/material.dart';
import 'package:flutter_news_reader/presentation/ui/screens/news_details_screen.dart';
import 'package:flutter_news_reader/presentation/ui/screens/offline_news_list_screen.dart';
import 'package:flutter_news_reader/presentation/ui/widgets/news_card.dart';
import 'package:flutter_news_reader/provider/data_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnlineNewsListScreen extends ConsumerWidget {
  const OnlineNewsListScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(DataProvider.articleDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Latest News"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          print("Refreshing data...");
          ref.refresh(DataProvider.articleDataProvider);
          print("Data refreshed!");
        },
        child: data.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailsScreen(
                          article: data[index],
                        ),
                      ),
                    );
                  },
                  child: NewsCard(
                    article: data[index],
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
    );
  }
}