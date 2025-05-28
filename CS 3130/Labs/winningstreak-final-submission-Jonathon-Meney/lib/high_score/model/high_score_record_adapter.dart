part of 'high_score_record.dart';

//this code takes some inspiration from
//https://medium.flutterdevs.com/hive-database-with-typeadapter-in-flutter-7390d0e515fa

///allow HSModels to be read and written to a hive database
class HighScoreRecordAdapter extends TypeAdapter<HighScoreRecord> {

  @override
  HighScoreRecord read (BinaryReader reader) {

    var numOfFields = reader.readByte();

    //build the map of fieldNumber: field
    //e.g. 0 : name
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++)
        reader.readByte(): reader.read(),
    };

    return HighScoreRecord(
        fields[0] as String,
        fields[1] as int,
        fields[2] as DateTime
    );
  }

  @override
  //unique number between 0 and 233
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, HighScoreRecord obj) {
    //high score record has:
    // field 0: String name,
    // field 1: int streakLength and
    // field 2: DateTime date

    writer
    ..writeByte(3) //3 fields
    ..writeByte(0) //next is field 0
    ..write(obj.name) //write the person's initials
    ..writeByte(1) //next is field 1
    ..write(obj.length)
    ..writeByte(2) //next field is 2
    ..write(obj.date);
  }
}