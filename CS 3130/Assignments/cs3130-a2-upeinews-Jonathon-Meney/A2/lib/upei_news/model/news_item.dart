import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Simple class to represent [NewsItem]s
class NewsItem extends Equatable {
  /// The [title] of the [NewsItem].
  final String title;

  /// The [body] of the [NewsItem].
  final String body;

  /// The [author] of the [NewsItem].
  final String author;

  /// The publication [date] of the [NewsItem].
  final DateTime date;

  /// Determines if the [NewsItem] has been read.
  bool isRead;

  /// Determines if the [NewsItem] has been bookmarked.
  bool isBookmarked;

  /// The url to find the [image].
  final String image;

  /// Constructs a [NewsItem].
  NewsItem(
      this.title, this.body, this.author, this.date, this.image, this.isRead,
      [this.isBookmarked = false]);

  /// Marks the [NewsItem] as read.
  void markAsRead() {
    isRead = true;
  }

  /// Marks the [NewsItem] as bookmarked.
  void bookmark() {
    isBookmarked = true;
  }

  /// properties involved in the override for == and hashCode.
  @override
  List<Object?> get props => [title, body, author, date];

  /// Equatable library convert this object to a string.
  @override
  bool get stringify => true;
}

/// [TypeAdapter] for use with hive local storage system.
class NewsItemAdapter extends TypeAdapter<NewsItem> {
  @override
  final typeId = 0;

  @override
  NewsItem read(BinaryReader reader) {
    return NewsItem(
      reader.readString(),
      reader.readString(),
      reader.readString(),
      DateTime.parse(reader.readString()),
      reader.readString(),
      reader.readBool(),
      reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, NewsItem obj) {
    writer.writeString(obj.title);
    writer.writeString(obj.body);
    writer.writeString(obj.author);
    writer.writeString(obj.date.toIso8601String());
    writer.writeString(obj.image);
    writer.writeBool(obj.isRead);
    writer.writeBool(obj.isBookmarked);
  }
}
