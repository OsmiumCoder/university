import 'package:a1_fakenews/reader/models/news_provider.dart';
import 'package:a1_fakenews/upei_news/model/news_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Screen to show a single [NewsArticleScreen].
class NewsArticleScreen extends StatelessWidget {
  /// The [article] to display.
  final NewsItem article;

  /// Constructs a [NewsArticleScreen] screen.
  const NewsArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder:
          (BuildContext context, NewsProvider newsProvider, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            title: Text(article.title),
            centerTitle: true,
            titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
            backgroundColor: Colors.grey[800],
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 30),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.red.shade900, width: 10)),
                    child: Image.network(article.image),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      article.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Text(
                    'Written by: ${article.author}',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Text(
                    '${DateTime.now().difference(article.date).inDays} days ago',
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      article.body,
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
