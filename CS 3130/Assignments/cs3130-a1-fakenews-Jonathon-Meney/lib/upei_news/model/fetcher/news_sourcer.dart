import 'package:a1_fakenews/upei_news/model/news_item.dart';

/// Abstract interface for a [NewsSourcer].
abstract class NewsSourcer {

  /// Returns a stream of [NewsItem]s
  Stream<NewsItem> getNewsStream();

}