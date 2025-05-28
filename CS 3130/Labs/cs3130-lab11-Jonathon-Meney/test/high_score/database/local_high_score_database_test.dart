import 'package:flutter_test/flutter_test.dart';
import 'package:test/test.dart' as tst;
import 'package:winning_streak/high_score/database/local_high_score_database.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:winning_streak/high_score/model/high_score_record.dart';


// Mock class
class MockHiveBox extends Mock implements Box {}

void main() {

  late Box box;
  late LocalHighScoreDatabase db;

  setUp(() {
    box = MockHiveBox();

  });

  test('create a local database', () async{
    when(()=>box.isOpen).thenReturn(true);
    expect(LocalHighScoreDatabase(box:box), isNotNull);
  });

  test('constructor checks if box is open', () {
    when(()=>box.isOpen).thenReturn(true);
    db = LocalHighScoreDatabase(box:box);
    verify (()=>box.isOpen).called(isPositive);
  });

  test('constructor throws if box is not open', () {
    when(()=>box.isOpen).thenReturn(false);
    expect(()=>LocalHighScoreDatabase(box:box), throwsA(isA<UnOpenedDBException>()), reason:"expected to throw");
  });

  test('db.put calls box.put never called for empty list', () {
    when( ()=>box.isOpen).thenReturn(true);
    when( ()=>box.put(any(), any())).thenAnswer( (_) async =>{} );
    List<HighScoreRecord> leaders = <HighScoreRecord>[];
    db = LocalHighScoreDatabase(box:box);
    db.put(leaders);
    verifyNever(()=>box.put(any(), any()));
  });

    test('db.put calls box.put X times for X records', () {
      when( ()=>box.isOpen).thenReturn(true);
      when( ()=>box.put(any(), any())).thenAnswer( (_) async =>{} );
      List<HighScoreRecord> leaders = <HighScoreRecord>[
          HighScoreRecord("A",1, DateTime.now()),
          HighScoreRecord("B",2, DateTime.now()),
          HighScoreRecord("C",3, DateTime.now())];
      db = LocalHighScoreDatabase(box:box);
      db.put(leaders);
      verify(()=>box.put(any(), any())).called(leaders.length);
    });

  test('db.put calls box.put with 0 and HighScoreRecord on first record', () {
    when( ()=>box.isOpen).thenReturn(true);
    when( ()=>box.put(any(), any())).thenAnswer( (_) async =>{} );

    HighScoreRecord hsrA = HighScoreRecord("A",1, DateTime.now());
    List<HighScoreRecord> leaders = <HighScoreRecord>[
      hsrA,
    ];
    db = LocalHighScoreDatabase(box:box);
    db.put(leaders);
    verify(()=>box.put(0, hsrA)).called(1);
  });

  test('db.put maintains List order when calling box.put', () {
    when( ()=>box.isOpen).thenReturn(true);
    when( ()=>box.put(any(), any())).thenAnswer( (_) async =>{} );
    List<HighScoreRecord> leaders = <HighScoreRecord>[
      HighScoreRecord("A",1, DateTime.now()),
      HighScoreRecord("B",2, DateTime.now()),
      HighScoreRecord("C",3, DateTime.now())];
    db = LocalHighScoreDatabase(box:box);
    db.put(leaders);
    for(var i = 0; i < leaders.length; i++) {
      verify(() => box.put(i, leaders[i])).called(1);
    }
  });

  test('if box.get returns empty list then db.getLeaders returns empty', () {
    when(()=>box.isOpen).thenReturn(true);
    when( ()=>box.length).thenReturn(0);
    when( ()=>box.get(any())).thenReturn(null);

    db=LocalHighScoreDatabase(box:box);
    List<HighScoreRecord> leaders = db.getLeaders();
    expect(leaders.length, equals(0));
  });

  test('db.getLeaders calls box.get for each of box.length items', () {
    when(()=>box.isOpen).thenReturn(true);
    when( ()=>box.length).thenReturn(3);
    when( ()=>box.get(any())).thenReturn(HighScoreRecord("A", 1, DateTime.now()));

    db=LocalHighScoreDatabase(box:box);
    List<HighScoreRecord> leaders = db.getLeaders();
    verify(()=>box.get(any())).called(3);

  });


  test('db.getLeaders preserves order from box.get', () {
    when(()=>box.isOpen).thenReturn(true);
    when( ()=>box.length).thenReturn(3);
    when( ()=>box.get(0)).thenReturn(HighScoreRecord("A", 1, DateTime.now()));
    when( ()=>box.get(1)).thenReturn(HighScoreRecord("B", 2, DateTime.now()));
    when( ()=>box.get(2)).thenReturn(HighScoreRecord("C", 3, DateTime.now()));

    db=LocalHighScoreDatabase(box:box);
    List<HighScoreRecord> leaders = db.getLeaders();
    expect(leaders[0].name, equals("A"));
    expect(leaders[1].name, equals("B"));
    expect(leaders[2].name, equals("C"));

  });


}

