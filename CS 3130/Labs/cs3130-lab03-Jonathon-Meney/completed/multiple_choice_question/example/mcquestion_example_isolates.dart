//time using separate isolates versus
//doing it on a single isolate with the event loop

import 'dart:io';
import 'dart:isolate';
import 'package:multiple_choice_question/multiple_choice_question.dart';

///get a question and return it through the isolate
void getQuestionAndSleep(SendPort p) async {
  MCQuestion q = await RandomQuestionFetch().fetch();

  //sleep for 1 second
  sleep(Duration(seconds:1));

  //send the question from this isolate
  Isolate.exit(p, q);
}

///retrieve a question in a separate isolate
Future<MCQuestion> getOnSeparateIsolate() async {
  //where to receive the result of the background isolate
  final p = ReceivePort();
  //spawn an isolate to run the getQuestion code
  await Isolate.spawn(getQuestionAndSleep, p.sendPort);
  //p.first contains the returned message value from the SendPort
  return await p.first;
}


///get a question and sleep using asynchronous code on the same isolate
Future<MCQuestion> singleIsolateRetrievalAndSleep() async{
  MCQuestion q = await RandomQuestionFetch().fetch();
  sleep(Duration(seconds:1));
  return q;
}


///Fetch 3 Questions using a single isolate and async and then using multiple isolates,
///compare the results
void main() async {

  //how long using a single isolate and event loop
  Stopwatch stopwatch = new Stopwatch()..start();

  //get and (later) print 3 questions
  Future<MCQuestion> q1 = singleIsolateRetrievalAndSleep();
  Future<MCQuestion> q2 = singleIsolateRetrievalAndSleep();
  Future<MCQuestion> q3 = singleIsolateRetrievalAndSleep();

  //wait for all 3 to complete then print them
  List<MCQuestion> listQ = await Future.wait( [q1,q2,q3]);
  listQ.forEach(print);

  //should be > 3 seconds (1 second per plus some print and setup time)
  print('Elapsed time for single isolate (expect 3+ secs): ${stopwatch.elapsed}');
  print("============================================\n");

  //how long multiple isolates take
  stopwatch.reset();

  Future<MCQuestion> q4 = getOnSeparateIsolate();
  Future<MCQuestion> q5 = getOnSeparateIsolate();
  Future<MCQuestion> q6 = getOnSeparateIsolate();

  //wait for all 3 to complete then print each
  listQ = await Future.wait( [q4,q5,q6]);
  listQ.forEach(print);


  //should be > 1 seconds (1 second to do all 3 retrieves and sleeps (at the same time)) plus some extra
  print('Elapsed time for multiple isolate (expect 1+ secs): ${stopwatch.elapsed}');
  print("============================================\n");
}