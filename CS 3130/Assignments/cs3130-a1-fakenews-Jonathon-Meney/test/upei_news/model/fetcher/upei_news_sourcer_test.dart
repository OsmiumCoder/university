import 'dart:async';

import 'package:a1_fakenews/upei_news/model/db/upei_news_database.dart';
import 'package:a1_fakenews/upei_news/model/fetcher/upei_news_sourcer.dart';
import 'package:a1_fakenews/upei_news/model/news_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockUPEINewsDatabase extends Mock implements UPEINewsDatabase {}

void main() {
  group('UPEINewsSourcer tests', () {
    late UPEINewsSourcer newsSourcer;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      newsSourcer = UPEINewsSourcer(client: mockHttpClient);
    });

    test('getNewsStream creates and streams correct news item with valid data',
        () async {
      when(() => mockHttpClient
              .get(Uri.parse("https://www.upei.ca/feeds/news.rss")))
          .thenAnswer((_) async => http.Response(validRssResponse, 200));

      when(() => mockHttpClient.get(Uri.parse(
              "https://www.upei.ca/communications/news/2024/02/avc-students-return-kenya-experiences-last-lifetime-0")))
          .thenAnswer((_) async => http.Response(fakeArticleHtml, 200));

      Stream<NewsItem> newsStream = newsSourcer.getNewsStream();

      // This forEach loop checking a single object is still valid as from the
      // response we expect a single NewsItem
      newsStream.forEach((element) {
        expect(
            element,
            NewsItem(
                "Test Title",
                "Test Description",
                "April Munro",
                DateTime(2024, 3, 3, 12),
                "https://www.upei.ca/sites/default/files/2024-02/Website%20Photos%20%2814%29.png",
                false));
      });
    });

    test(
        'getNewsStream creates and streams news item with default values on missing data',
        () async {
      when(() => mockHttpClient
              .get(Uri.parse("https://www.upei.ca/feeds/news.rss")))
          .thenAnswer((_) async => http.Response(missingDataRssResponse, 200));

      when(() => mockHttpClient.get(Uri.parse(
              "https://www.upei.ca/communications/news/2024/02/avc-students-return-kenya-experiences-last-lifetime-0")))
          .thenAnswer((_) async => http.Response(fakeArticleHtml, 200));

      Stream<NewsItem> newsStream = newsSourcer.getNewsStream();

      // This forEach loop checking a single object is still valid as from the
      // response we expect a single NewsItem
      newsStream.forEach((element) {
        expect(
            element,
            NewsItem(
                "Test Title",
                "",
                "",
                DateTime(2024, 3, 3, 12),
                "https://www.upei.ca/sites/default/files/2024-02/Website%20Photos%20%2814%29.png",
                false));
      });
    });

    test(
        'getNewsStream creates and streams news item with default time on missing time',
        () async {
      when(() => mockHttpClient
              .get(Uri.parse("https://www.upei.ca/feeds/news.rss")))
          .thenAnswer((_) async => http.Response(missingTimeRssResponse, 200));

      when(() => mockHttpClient.get(Uri.parse(
              "https://www.upei.ca/communications/news/2024/02/avc-students-return-kenya-experiences-last-lifetime-0")))
          .thenAnswer((_) async => http.Response(fakeArticleHtml, 200));

      Stream<NewsItem> newsStream = newsSourcer.getNewsStream();

      // This forEach loop checking a single object is still valid as from the
      // response we expect a single NewsItem
      newsStream.forEach((element) {
        DateTime now = DateTime.now();
        expect(element.date.year, now.year);
        expect(element.date.month, now.month);
        expect(element.date.day, now.day);
        expect(element.date.hour, now.hour);
        expect(element.date.minute, now.minute);
      });
    });
  });
}

const validRssResponse = '''
<rss version="2.0">
  <channel>
    <item>
      <title>Test Title</title>
      <description>Test Description</description>
      <link>https://www.upei.ca/communications/news/2024/02/avc-students-return-kenya-experiences-last-lifetime-0</link>
      <pubDate>Thu, 03 Mar 2024 12:00:00</pubDate>
      <dc:creator>April Munro</dc:creator>
    </item>
  </channel>
</rss>
''';

const missingDataRssResponse = '''
<rss version="2.0">
  <channel>
    <item>
      <title>Test Title</title>
      <link>https://www.upei.ca/communications/news/2024/02/avc-students-return-kenya-experiences-last-lifetime-0</link>
      <pubDate>Thu, 03 Mar 2024 12:00:00</pubDate>      
    </item>
  </channel>
</rss>
''';

const missingTimeRssResponse = '''
<rss version="2.0">
  <channel>
    <item>
      <title>Test Title</title>
      <description>Test Description</description>
      <link>https://www.upei.ca/communications/news/2024/02/avc-students-return-kenya-experiences-last-lifetime-0</link>
      <dc:creator>April Munro</dc:creator>
    </item>
  </channel>
</rss>
''';

const fakeArticleHtml = '''
<!DOCTYPE html>
<html>
  <body>
    <div class="medialandscape">
      <img src="https://www.upei.ca/sites/default/files/2024-02/Website%20Photos%20%2814%29.png" />
    </div>
  </body>
</html>
''';
