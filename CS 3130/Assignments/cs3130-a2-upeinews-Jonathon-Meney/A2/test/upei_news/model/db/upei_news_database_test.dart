import 'package:a1_fakenews/upei_news/model/db/upei_news_database.dart';
import 'package:a1_fakenews/upei_news/model/news_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';

class MockHiveBox extends Mock implements Box {}

class MockUPEINewsDatabase extends Mock implements UPEINewsDatabase {}

void main() {
  group('UPEINewsDatabase tests', () {
    late Box box;
    late UPEINewsDatabase db;

    setUp(() {
      box = MockHiveBox();
    });

    test('create a local database', () async {
      //send the Mocked box into the LocalHighScoreDatabase
      when(() => box.isOpen).thenReturn(true);
      expect(() => UPEINewsDatabase(box: box), isNotNull);
    });

    test('constructor checks if box is open', () {
      when(() => box.isOpen).thenReturn(true);
      db = UPEINewsDatabase(box: box);
      verify(() => box.isOpen).called(isPositive);
    });

    test('constructor throws if box is not open', () {
      when(() => box.isOpen).thenReturn(false);
      expect(
          () => UPEINewsDatabase(box: box), throwsA(isA<UnOpenedDBException>()),
          reason: "expected to throw");
    });

    test('contains returns true if box has given article', () {
      NewsItem article =
          NewsItem('title', 'body', 'author', DateTime.now(), 'image', false);

      when(() => box.isOpen).thenReturn(true);
      when(() => box.values).thenReturn([article, article, article]);
      db = UPEINewsDatabase(box: box);
      expect(db.contains(article), true);
      verify(() => box.values.contains(article)).called(1);
    });

    test('contains returns true if box has given article', () {
      NewsItem article =
          NewsItem('title', 'body', 'author', DateTime.now(), 'image', false);

      when(() => box.isOpen).thenReturn(true);
      when(() => box.values).thenReturn([article, article, article]);
      db = UPEINewsDatabase(box: box);
      expect(
          db.contains(NewsItem(
              'not a title', 'body', 'author', DateTime.now(), 'image', false)),
          false);
      verify(() => box.values.contains(article)).called(1);
    });

    test('add calls add if news item not in box yet', () async {
      NewsItem article =
          NewsItem('title', 'body', 'author', DateTime.now(), 'image', false);

      when(() => box.isOpen).thenReturn(true);
      when(() => box.values).thenReturn([]);
      when(() => box.add(article)).thenAnswer((_) async => 0);
      db = UPEINewsDatabase(box: box);
      db.add(article);
      verify(() => box.values.contains(article)).called(1);
      verify(() => box.add(article)).called(1);
      verifyNever(() => box.putAt(0, article));
    });

    test('add calls putAt if news item is already in box', () async {
      NewsItem article =
          NewsItem('title', 'body', 'author', DateTime.now(), 'image', false);

      when(() => box.isOpen).thenReturn(true);
      when(() => box.values).thenReturn([article]);
      when(() => box.putAt(0, article)).thenAnswer((_) async {});
      db = UPEINewsDatabase(box: box);
      db.add(article);
      verify(() => box.values.contains(article)).called(2);
      verifyNever(() => box.add(article));
      verify(() => box.putAt(0, article)).called(1);
    });

    test('getStoredMatch returns the stored matching news item', () async {
      NewsItem article =
          NewsItem('title', 'body', 'author', DateTime.now(), 'image', false);

      when(() => box.isOpen).thenReturn(true);
      when(() => box.values).thenReturn([article]);
      db = UPEINewsDatabase(box: box);
      NewsItem storedMatch = db.getStoredMatch(article);
      expect(storedMatch, article);
    });

    test('getBookmarkedArticles returns only bookmarked articles', () async {
      NewsItem bookmarkedArticle = NewsItem(
          'title', 'body', 'author', DateTime.now(), 'image', false, true);
      NewsItem article = NewsItem(
          'title', 'body', 'author', DateTime.now(), 'image', false);

      when(() => box.isOpen).thenReturn(true);
      when(() => box.values).thenReturn([article, bookmarkedArticle] as Iterable<dynamic>);
      db = UPEINewsDatabase(box: box);
      List<NewsItem> bookmarkedArticles = db.getBookmarkedArticles();
      expect(bookmarkedArticles.length, 1);
      for (var element in bookmarkedArticles) {
        expect(element.isBookmarked, true);
      }
    });
  });
}
