import 'dart:async';

import 'package:a1_fakenews/upei_news/model/fetcher/news_sourcer.dart';
import 'package:a1_fakenews/upei_news/model/news_item.dart';
import 'package:dart_rss/dart_rss.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parse;
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';

/// [NewsSourcer] for fetching UPEI news from its RSS feed.
class UPEINewsSourcer extends NewsSourcer {
  final http.Client client;

  UPEINewsSourcer({client}) : client = client ?? http.Client();

  @override
  Stream<NewsItem> getNewsStream() async* {
    final response =
        await client.get(Uri.parse("https://www.upei.ca/feeds/news.rss"));

    RssFeed feed = RssFeed.parse(response.body);

    for (RssItem rssItem in feed.items) {
      // Data for a NewsItem
      var title = rssItem.title ?? "";
      String parsedBody = _getParsedBody(rssItem);
      var author = rssItem.dc?.creator ?? "";
      DateTime date = _getDateTimeFromString(rssItem);
      String image = await _getImage(rssItem);

      NewsItem newsItem =
          NewsItem(title, parsedBody, author, date, image, false, false);

      yield newsItem;
    }
  }

  /// Returns the articles image url.
  Future<String> _getImage(RssItem rssItem) async {
    var image = "";

    var link = rssItem.link;
    final response = await client.get(Uri.parse(link!));

    if (response.statusCode == 200) {
      var document = parse.parse(response.body);
      dom.Element? link = document
          .getElementsByClassName("medialandscape")[0]
          .querySelector('img');
      String imageLink = link != null ? link.attributes['src'] ?? "" : "";
      image = "https://upei.ca/" + imageLink;
    }
    return image;
  }

  /// Returns the articles date as a formatted [DateTime] object.
  DateTime _getDateTimeFromString(RssItem rssItem) {
    var date = rssItem.pubDate;
    if (date is String) {
      var dateFormat = DateFormat("E, d MMM y H:m:s");
      return dateFormat.parse(date);
    }

    // If there is no date found
    return DateTime.now();
  }

  /// Returns the article body without html tags.
  String _getParsedBody(RssItem rssItem) {
    var body = rssItem.description ?? "";
    final document = parse.parse(body);
    final String parsedBody =
        parse.parse(document.body?.text).documentElement?.text ?? "";
    return parsedBody;
  }
}
