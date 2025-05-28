[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/q5ihAY3p)
# Lab 09

This lab takes a slightly different approach to development than we have been using.

We've been using a somewhat adhoc development style, we write code and maybe some unit-tests. Maybe at best we are operating a 'test-last' approach, which is perhaps better than a no-test approach but generally considered to be one of the poorer development approaches.

Teams and companies typically have a required software development process. It typically involves integrating how the user will use a product in choosing the development path and testing.

In this lab we will follow Test Driven Development (TDD) model to implement a storage solution for our local high score list (high scores just from this device).

Our local high scores will be stored using a Hive database. Hive is a light-weight, fast no-sql database. It stores data in `boxes` using key:value pairs. It provides typical `CRUD` (create, read, update and delete records) operations as expected from a database.

We will learn just enough of the Hive API to support our application but more information can be found below:

https://pub.dev/packages/hive
https://docs.hivedb.dev/#/

Recall from last lab that we already have an in-memory high score list functioning.

Two laws of Test-driven development(TDD) as per: https://www.javiersaldana.com/articles/tech/refactoring-the-three-laws-of-tdd):

1. Write only enough of a unit test to fail.
2. Write only enough production code to make the failing unit test pass.

This is an incremental approach, we write a unit-test then implement the solution and then repeat.

## Setup

Add the hive dependency to your pubspec.yaml file:

```yaml
hive: ^2.0.5
hive_flutter: ^1.1.0
```

As per the instructions at:
https://pub.dev/packages/hive/install


## Let's start

- [ ] Open `high_score/database/local_high_score_database.dart'

This will be a simple wrapper file around our Hive database, then if we ever wanted to change our implementation we don't have to alter source code outside of this file (except maybe unit-tests and the odd set-up).

Our LocalHighScoreCubit for example will talk to this file.

**unit-test #1**

*Create a HighScoreDatabase object. All of our tests are going to use a Mocked Hive database. So the database needs to be able to accept a Hive database as a parameter*

- [ ] open the testing file: `test/high_score/database/local_high_score_database_test.dart`

- add the first test:

```dart
void main() {

  late Box box;
  late LocalHighScoreDatabase db;

    setUp(() {
      box = MockHiveBox();

    });

    test('create a local database', () async{
      //send the Mocked box into the LocalHighScoreDatabase
      expect(()=>LocalHighScoreDatabase(box:box), isNotNull);
    });
}
```

Pretty simple so far, create the object and expect the object isNotNull

Notice inside the file you are given the code for the Mocked Hive and a few imports including Mocktail and the testing libraries.

- Add the code to make this unit-test pass (inside  `local_high_score_database.dart`):

```dart
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:winning_streak/high_score/model/high_score_record.dart';

class LocalHighScoreDatabase {
  static const String dbName = "localLeaderboard";
  static const String _leaders = "leaders";

  //the hive box
  late final Box box;

  LocalHighScoreDatabase({box} ) : this.box=box??Hive.box<HighScoreRecord>(dbName){

  }

//plus some existing helper methods down here
```

- Notice how the constructor takes in an optional box object. This is designed specically to make it easier to test. If no Hive box database is passed in then it defaults to `Hive.box ...`

Back in the testing file run the test.

- it should pass but if not double check you might need some minor adjustments.

**unit-test #2**

*`LocalHighScoreDatabase` should check if the Hive.box is open before proceeding any further.*

*A nuance of Hive is that the boxes have to be opened - this loads them into memory - before you can use them. If someone is creating a LocalHighScoreDatabase object the Hive.box should already be opened.*

unit-test:

```dart
test('constructor checks if box is open', () {
    when(()=>box.isOpen).thenReturn(true);
    db = LocalHighScoreDatabase(box:box);
    verify (()=>box.isOpen).called(isPositive);
  });
});
```

**Explanation** the above `verify` will check to see which methods or calls have been made. We expect that box.isOpen has to be checked at least once to see if the db is open.

Recall that the Hive.box is a Mock and so we mock the .isOpen field to always return true using the  `when` method.

Implement the fix for this unit-test:

source code `local_high_score_database` update the constructor as:
```dart
///constructor ensures box is open
LocalHighScoreDatabase({box} ) : this.box=box??Hive.box<HighScoreRecord>(dbName){
  if (!this.box.isOpen) {
    print("box is not open yet, ack");
  }
}
```

**unit-test 3**

*If the Hive.box is not yet open the constructor for `LocalHighScoreDatabase` should throw `UnOpenedDBException`.*

Note: We'll have to update our first unit-test at this point because we need to Mock the `isOpen` field.  

Update first test case:

```dart
test('create a local database', () {
  when(()=>box.isOpen).thenReturn(true);
  expect(()=>LocalHighScoreDatabase(box:box), isNotNull);
});
```
Implement 3rd unit-test:

```dart
test('constructor throws if box is not open', () {
  when(()=>box.isOpen).thenReturn(false);
  expect(()=>LocalHighScoreDatabase(box:box), throwsA(isA<UnOpenedDBException>()), reason:"expected to throw");
});

```

Implement the solution to fix this unit-test in `local_high_score_database.dart`:

```dart
//imports up here

class UnOpenedDBException implements Exception { }

class LocalHighScoreDatabase {
  static const String dbName = "localLeaderboard";
  static const String _leaders = "leaders";

  //the hive box
  late final Box box;

  LocalHighScoreDatabase({box} ) : this.box=box??Hive.box<HighScoreRecord>(dbName){
    if (!this.box.isOpen) {
      throw UnOpenedDBException();
    }
  }
}
```

- [ ] run all the unit-tests again. Make sure everything is passing.

Ok we are starting to make some progress now. We need to be able to put information into the `Hive.box` and retrieve it out of the `Hive.box`. Start with `put`.

## put

`put` will accept a `List<HighScoreRecord>` and add the List to the box.  

**unit-test 4**

*`box.put` is not called when an empty list is passed to database.put*

If there aren't any records to upload then nothing is attempted to be uploaded ... simple enough.

- unit-test: note we mocked the box.put method although it technically isn't required.


```dart
test('db.put calls box.put never called for empty list', () {
   when( ()=>box.isOpen).thenReturn(true);
   when( ()=>box.put(any(), any())).thenAnswer( (_) async =>{} );
   List<HighScoreRecord> leaders = <HighScoreRecord>[];
   db = LocalHighScoreDatabase(box:box);
   db.put(leaders);
   verifyNever(()=>box.put(any(), any()));
 });

```

Notice how `any(), any()` is used to indicate the method signature can handle any parameters (and in the verifyNever call).

- solution code:

```dart
void put(List<HighScoreRecord> leaders) {
    //not much to see here yet
  }
```

This test and solution could prove valuable in the future to ensure we don't run into problems down the road.

**unit-test 5**

*`box.put` is called the same number of times as the length of the list passed to the LocalHighScoreDatabase.put method.

- this is a generalized version of the last test

unit-test:

```dart
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
```

solution code:

```dart
void put(List<HighScoreRecord> leaders) {
  for(var i = 0; i < leaders.length; i++) {
    box.put(i, leaders[i]);
  }
}
```

*Note: A Type Adapter has already been provided to allow `HighScoreRecords` to be serialized and stored in the Hive DB and retrieved back out. It is in `high_score_record_adapter.dart`*.



**unit-test 6**

- the first high score record in the list should be box.put into key: 0

unit-test:

```dart
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
```

- no further solution required for this test.

**unit-test 7**

- order of leaderboard needs to be maintained on box.put

```dart
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
```

-once again no solution should be required but run the tests to ensure they all pass.

We are ready to test the ability to retrieve data from the box and return it as a List.

Just a couple of tests should get us to the finish line.

## getLeaders

**unit-test 8**


```dart
test('if box.get returns empty list then db.getLeaders returns empty', () {
  when(()=>box.isOpen).thenReturn(true);
  when( ()=>box.length).thenReturn(0);
  when( ()=>box.get(any())).thenReturn(null);

  db=LocalHighScoreDatabase(box:box);
  List<HighScoreRecord> leaders = db.getLeaders();
  expect(leaders.length, equals(0));
});
```

solution:

```dart
List<HighScoreRecord> getLeaders() {
  List<HighScoreRecord> hsr =<HighScoreRecord> [];
  for (var i = 0; i < box.length; i++) {
    hsr.add(box.get(i));
  }
  return hsr;
}
```

We wrote a little more than the needed code there but the strategy involving the `box.length` lead us right into it.

Add a test to ensure the order of the final List matches the order of the indexes they were retrieved from:

**unit-test 9**

```dart
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
```

**unit-test 10**

Add one last unit-test to verify that box.get(any()) is called exactly box.length times when db.getLeaders() is called.

<details><summary>hint</summary>

<p><br>

```dart
test('db.getLeaders calls box.get for each of box.length items', () {
  when(()=>box.isOpen).thenReturn(true);
  when( ()=>box.length).thenReturn(3);
  when( ()=>box.get(any())).thenReturn(HighScoreRecord("A", 1, DateTime.now()));

  db=LocalHighScoreDatabase(box:box);
  List<HighScoreRecord> leaders = db.getLeaders();
  verify(()=>box.get(any())).called(3);

});

```

</p>

</details>


We have now tested our new LocalHighScoreDatabase. We should be able to use it in our cubit (the associated unit-testing is left to you on this one - but you can mock the db and just verify that the correct methods are called!).

inside `local_high_score_cubit.dart` alter the _fetchHighScores method to look like this:

```dart
Future<void> _fetchHighScores() async {
  emit(state.copyWith(status:HSStatus.loading));
  List<HighScoreRecord> highScores = db.getLeaders();
  //get the high scores
  emit(state.copyWith(status:HSStatus.loaded, leaderboard: highScores));
}
```

And the `_updateScoreboard` method so the last line is:

```dart
//update the leaderboard
void updateScoreboard(int streakLength,DateTime when, String initials ) {
  //...existing code



  db.put(leaders);
}
```

Run the app and you should have a functioning persistent scoreboard!
