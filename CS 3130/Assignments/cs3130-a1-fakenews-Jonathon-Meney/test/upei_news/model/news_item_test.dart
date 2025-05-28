import 'package:a1_fakenews/upei_news/model/news_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NewsItem tests', () {
    NewsItem newsItem =
        NewsItem('title', 'body', 'author', DateTime.utc(2000), 'image', false);
    test('NewsItem constructs correctly', () {
      expect(newsItem.title, 'title');
      expect(newsItem.body, 'body');
      expect(newsItem.author, 'author');
      expect(newsItem.date, DateTime.utc(2000));
      expect(newsItem.image, 'image');
      expect(newsItem.isRead, false);
    });

    test('marked as read marks isRead true', () {
      expect(newsItem.title, 'title');
      expect(newsItem.body, 'body');
      expect(newsItem.author, 'author');
      expect(newsItem.date, DateTime.utc(2000));
      expect(newsItem.image, 'image');
      expect(newsItem.isRead, false);
      newsItem.markAsRead();
      expect(newsItem.title, 'title');
      expect(newsItem.body, 'body');
      expect(newsItem.author, 'author');
      expect(newsItem.date, DateTime.utc(2000));
      expect(newsItem.image, 'image');
      expect(newsItem.isRead, true);
    });

    test('equals operator', () {
      NewsItem other = NewsItem(
          'title', 'body', 'author', DateTime.utc(2000), 'image', false);
      expect(newsItem == other, true);
    });

    test('hashCode equality', () {
      NewsItem other = NewsItem(
          'title', 'body', 'author', DateTime.utc(2000), 'image', false);
      expect(newsItem.hashCode == other.hashCode, true);
    });

    test('props return equatable prop values', () {
      var props = newsItem.props;
      expect(props, ['title', 'body', 'author', DateTime.utc(2000), false]);
    });

    test('toString returns correct string format', () {
      expect(newsItem.toString(),
          'NewsItem(title, body, author, 2000-01-01 00:00:00.000Z, false)');
    });
  });
}
