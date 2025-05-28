import 'package:a1_fakenews/reader/models/news_provider.dart';
import 'package:a1_fakenews/reader/screens/components/news_index_list_component.dart';
import 'package:a1_fakenews/reader/screens/components/sliver_app_bar_component.dart';
import 'package:a1_fakenews/upei_news/model/news_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Home screen of application.
class NewsIndexScreen extends StatelessWidget {
  /// Constructs a [NewsIndexScreen] screen.
  const NewsIndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        return Scaffold(
          backgroundColor: Colors.grey[900],
          body: [
            CustomScrollView(slivers: [
              const SliverAppBarComponent(),
              newsProvider.articles.isEmpty
                  ? const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()))
                  : SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: const TextStyle(color: Colors.white),
                          onChanged: (query) {
                            newsProvider.updateSearchQuery(query);
                          },
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: 'Search articles...',
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: newsProvider.articles.length,
                      (context, index) {
                // Article for the current list tile.
                NewsItem article = newsProvider.articles[index];

                // The list item for an article.
                return NewsIndexListComponent(article: article);
              })),
            ]),
            CustomScrollView(slivers: [
              const SliverAppBarComponent(),
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: newsProvider.bookmarkedArticles.length,
                      (context, index) {
                // Article for the current list tile.
                NewsItem article = newsProvider.bookmarkedArticles[index];

                // The list item for an article.
                return NewsIndexListComponent(article: article);
              })),
            ])
          ][newsProvider.currentNavigationIndex],
          bottomNavigationBar: NavigationBar(
            backgroundColor: Colors.grey[600],
            indicatorColor: Colors.red[900],
            indicatorShape: const CircleBorder(),
            selectedIndex: newsProvider.currentNavigationIndex,
            onDestinationSelected: (newIndex) {
              newsProvider.changeNavigationIndex(newIndex);
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark),
                label: 'Bookmarked',
              ),
            ],
          ),
        );
      },
    );
  }
}
