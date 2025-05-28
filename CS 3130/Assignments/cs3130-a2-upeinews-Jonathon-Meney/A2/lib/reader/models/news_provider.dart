import 'dart:async';

import 'package:a1_fakenews/upei_news/model/db/upei_news_database.dart';
import 'package:a1_fakenews/upei_news/model/news_item.dart';
import 'package:flutter/material.dart';

/// Keeps track of nav bar index.
enum NavigationIndex { home, bookmarked }

/// [NewsProvider] for notifying listeners of news changes.
class NewsProvider extends ChangeNotifier {
  /// Stream of articles that can be listened to.
  ///
  /// Behaves as a broadcast stream.
  List<NewsItem> _articles = [];

  /// [bookmarkedArticles] will provide a list of bookmarked articles.
  List<NewsItem> bookmarkedArticles = [];

  /// The current navigation bar index.
  ///
  /// Default is home.
  int currentNavigationIndex = NavigationIndex.home.index;

  /// The list of available articles.
  List<NewsItem> get articles => _articles;

  /// Constructs a new [NewsProvider]
  NewsProvider() {
    // Ensures latest news on construct.
    updateNews();
    // Loads bookmarked articles into provider.
    getBookmarkedArticles();
  }

  /// Fetches a [Stream] of [NewsItem]s and caches them in the article list.
  Future<void> updateNews() async {
    Stream<NewsItem> articleStream =
        UPEINewsDatabase().getAllNewsItems().asBroadcastStream();

    // Empty the article list if we update the news from source again.
    _articles = [];

    // Add each NewsItem to the article list.
    articleStream.forEach((element) {
      if (!_articles.contains(element)) {
        // If we have a stored version use it to track read and bookmark status.
        if (UPEINewsDatabase().contains(element)) {
          NewsItem storedVersion = UPEINewsDatabase().getStoredMatch(element);
          _articles.add(storedVersion);
        } else {
          _articles.add(element);
        }
        notifyListeners();
      }
    });
  }

  /// Marks the given [NewsItem] as bookmarked and notifies listeners to update.
  Future<void> bookmarkArticle(NewsItem article) async {
    article.bookmark();
    if (!bookmarkedArticles.contains(article)) {
      bookmarkedArticles.add(article);
    }

    //Saves the article to database for offline reading.
    await UPEINewsDatabase().add(article);

    notifyListeners();
  }

  /// Marks an [article] as read and notifies listeners to update.
  Future<void> markArticleAsRead(NewsItem article) async {
    // Only mark read if not already.
    if (!article.isRead) {
      article.markAsRead();

      // Store the state of an article to maintain read status.
      await UPEINewsDatabase().add(article);

      notifyListeners();
    }
  }

  /// Updates the list of bookmarked articles that are locally saved.
  void getBookmarkedArticles() {
    bookmarkedArticles = UPEINewsDatabase().getBookmarkedArticles();
  }

  /// Changes nav index to given [newIndex].
  ///
  /// If invalid index is given will default to home.
  void changeNavigationIndex(int newIndex) {
    switch (newIndex) {
      case 0:
        currentNavigationIndex = NavigationIndex.home.index;
        break;
      case 1:
        currentNavigationIndex = NavigationIndex.bookmarked.index;
        break;
      default:
        currentNavigationIndex = NavigationIndex.home.index;
    }
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    if (query == "") {
      updateNews();
    }
    else {
      _articles = _articles.where((element) {
        return (element.title.toLowerCase()).contains(query.toLowerCase());
      }).toList();
    }
  }
}
