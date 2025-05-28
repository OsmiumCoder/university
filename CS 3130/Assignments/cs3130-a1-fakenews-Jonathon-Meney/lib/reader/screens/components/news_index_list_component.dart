import 'package:a1_fakenews/reader/models/news_provider.dart';
import 'package:a1_fakenews/routes.dart';
import 'package:a1_fakenews/upei_news/model/news_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// List item for news index article item.
class NewsIndexListComponent extends StatelessWidget {
  /// Constructs a [NewsIndexListComponent].
  const NewsIndexListComponent({
    super.key,
    required this.article,
  });

  /// The article to display some of its information.
  final NewsItem article;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7),
      child: Card(
        color: article.isRead
            // if an article has been read go lighter
            ? Colors.red[300]
            // the article has not been read yet go darker
            : Colors.red[900],
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Container(
                margin: const EdgeInsets.symmetric(vertical: 2.5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.5)),
                child: Image.network(article.image)),

            // Bookmark icon button.
            trailing: IconButton(
              isSelected: false,
              onPressed: () async {
                await context.read<NewsProvider>().bookmarkArticle(article);
              },
              icon: article.isBookmarked
                  ? const Icon(Icons.bookmark_added)
                  : const Icon(Icons.bookmark_add_outlined),
            ),
            title: Text(
              article.title,
              overflow: TextOverflow.fade,
              softWrap: false,
            ),
            onTap: () async {
              // Clicking on an article opens and marks it read.
              await context.read<NewsProvider>().markArticleAsRead(article);
              Navigator.pushNamed(context, RouteGenerator.articleRoute,
                  arguments: {'article': article});
            },
          ),
        ),
      ),
    );
  }
}
