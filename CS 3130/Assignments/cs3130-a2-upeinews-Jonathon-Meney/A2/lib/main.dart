import 'package:a1_fakenews/reader/models/news_provider.dart';
import 'package:a1_fakenews/routes.dart';
import 'package:a1_fakenews/upei_news/model/db/upei_news_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await UPEINewsDatabase.init();

  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return NewsProvider();
      },
      child: const MaterialApp(
        initialRoute: RouteGenerator.indexRoute,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
