import 'package:flutter/material.dart';
import 'package:flutter_news_reader/data/models/news_model.dart';
import 'package:flutter_news_reader/data/offline_data/offline_news_data.dart';
import 'package:flutter_news_reader/presentation/ui/screens/news_details_screen.dart';
import 'package:flutter_news_reader/presentation/ui/widgets/news_card.dart';

class OfflineNewsListScreen extends StatelessWidget {
  const OfflineNewsListScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Latest News'),
            Spacer(),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text('Offline')
          ],
        ),
      ),
      body: FutureBuilder<List<ArticlesData>>(
        future: LocalDataStorage.getArticlesFromDatabase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error.toString()}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            final articlesDataList = snapshot.data;

            return ListView.builder(
              itemCount: articlesDataList?.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsDetailsScreen(
                          article: articlesDataList![index],
                        ),
                      ),
                    );
                  },
                  child: NewsCard(
                    article: articlesDataList![index],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
