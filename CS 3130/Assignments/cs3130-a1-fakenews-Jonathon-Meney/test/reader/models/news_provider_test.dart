import 'package:a1_fakenews/reader/models/news_provider.dart';
import 'package:a1_fakenews/upei_news/model/news_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveBox extends Mock implements Box {}

void main() {
  group('NewsProvider tests', () {
    NewsProvider newsProvider = NewsProvider();

    test('news provider initializes with news', () {
      expect(newsProvider.articles.length, greaterThan(0));
    });

    test('updateNews updates news', () async {
      List<NewsItem> oldArticles = newsProvider.articles;
      await newsProvider.updateNews();
      List<NewsItem> newArticles = newsProvider.articles;

      expect(oldArticles, isNot(equals(newArticles)));
    });

    test('markArticleAsRead updates isRead on article to true', () {
      NewsItem article = newsProvider.articles[0];
      expect(article.isRead, false);

      newsProvider.markArticleAsRead(article);

      NewsItem updatedArticle = newsProvider.articles[0];
      expect(updatedArticle.isRead, true);
    });

    test('markArticleAsRead does not remove isRead status', () async {
      // Already read article.
      NewsItem article =
          NewsItem('title', 'body', 'author', DateTime.now(), 'image', true);

      newsProvider.markArticleAsRead(article);

      NewsItem updatedArticle = newsProvider.articles[0];
      expect(updatedArticle.isRead, true);
    });

    test('updateNews notifies listeners of a change', () async {
      bool notifyListenerCalled = false;

      newsProvider.addListener(() {
        notifyListenerCalled = true;
      });

      await newsProvider.updateNews();

      expect(notifyListenerCalled, true);
    });

    test('markArticleAsRead notifies listeners of a change', () {
      bool notifyListenerCalled = false;

      newsProvider.addListener(() {
        notifyListenerCalled = true;
      });

      NewsItem article = newsProvider.articles[0];
      newsProvider.markArticleAsRead(article);

      expect(notifyListenerCalled, true);
    });
  });
}
