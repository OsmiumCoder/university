import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:winning_streak/high_score/model/high_score_record.dart';

class UnOpenedDBException implements Exception { }

class LocalHighScoreDatabase {

  static const String dbName = "localLeaderboard";
  static const String _leaders = "leaders";

  //the hive box
  late final Box box;

  LocalHighScoreDatabase({box} ) : box=box??Hive.box<HighScoreRecord>(dbName){
    if (!this.box.isOpen) {
      throw UnOpenedDBException();
    }
  }

  static Future<void> init() async{
    //hive documentation states to register the type adapter first
    Hive.registerAdapter(HighScoreRecordAdapter());

    await Hive.initFlutter();
    await Hive.openBox<HighScoreRecord>(dbName);
  }

  static Future<void> close() async {
    await Hive.close();
  }

  void put(List<HighScoreRecord> leaders) {
    for(var i = 0; i < leaders.length; i++) {
      box.put(i, leaders[i]);
    }
  }

  List<HighScoreRecord> getLeaders() {
    List<HighScoreRecord> hsr =<HighScoreRecord> [];
    for (var i = 0; i < box.length; i++) {
      hsr.add(box.get(i));
    }
    return hsr;
  }
}