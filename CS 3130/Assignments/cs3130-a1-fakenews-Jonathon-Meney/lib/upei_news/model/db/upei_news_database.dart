import 'package:a1_fakenews/upei_news/model/fetcher/upei_news_sourcer.dart';
import 'package:a1_fakenews/upei_news/model/news_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// [UnOpenedDBException] should be thrown if a hive box is accessed before
/// being opened.
class UnOpenedDBException implements Exception {}

/// Singleton class for interacting with [NewsItem] local storage.
class UPEINewsDatabase {
  /// The name of the database for storing [NewsItem]s.
  static const String dbName = "localNews";

  /// The hive box.
  late final Box box;

  // /// Singleton instance of the [UPEINewsDatabase].
  // static final UPEINewsDatabase _singleton = UPEINewsDatabase();

  /// [UPEINewsSourcer] for retrieving news from the web.
  final UPEINewsSourcer _news = UPEINewsSourcer();


  UPEINewsDatabase({box} ) : box=box??Hive.box<NewsItem>(dbName){
    if (!this.box.isOpen) {
      throw UnOpenedDBException();
    }
  }

  /// [init] will register all type adapters and open the hive box.
  static Future<void> init() async {
    Hive.registerAdapter(NewsItemAdapter());

    await Hive.initFlutter();
    await Hive.openBox<NewsItem>(dbName);
  }

  /// Closes all open hive boxes.
  static Future<void> close() async {
    await Hive.close();
  }

  /// Determines if the given [NewsItem] is already in the box.
  bool contains(NewsItem article) {
    return box.values.contains(article);
  }

  /// Adds a given [NewsItem] to the box if not already in the box.
  ///
  /// If it is in the box we update it.
  Future<void> add(NewsItem article) async {
    if (!contains(article)) {
      await box.add(article);
    } else {
      int index = box.values.toList().indexOf(article);
      await box.putAt(index, article);
    }
  }

  /// Returns the already saved version of matching a [NewsItem].
  ///
  /// Stored matches should be used over newly created [NewsItem]s to maintain
  /// read and bookmarked status.
  NewsItem getStoredMatch(NewsItem other) {
    return box.values.firstWhere((element) => element == other);
  }

  /// Returns the stream of [NewsItem]s from the [UPEINewsSourcer].
  Stream<NewsItem> getAllNewsItems() {
    return _news.getNewsStream();
  }

  /// Returns an list of bookmarked [NewsItem]s.
  List<NewsItem> getBookmarkedArticles() {
    return box.values.where((element) => element.isBookmarked).toList()
        as List<NewsItem>;
  }
}
