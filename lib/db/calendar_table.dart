
import 'package:cnpm/model/calendar.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';

class CalendarTable{

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'cnpm161.db'),
      onCreate: (database, version) async {
        await database.execute(CREATE_TABLE_QUERY);
      },
      version: 2,
    );
  }
  static const TABLE_NAME= 'calendar';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME(
    id INTEGER PRIMARY KEY,
    name TEXT,
    title TEXT,
    room TEXT,
    clas TEXT,
    date TEXT,
    idUser INTEGER
    );
  ''';
  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';
  static const INSERT_VALUE_1 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(1,"Lập Trình JAVA","1-3","305","07CNTT1","2022-01-24",1)
  ''';
  static const INSERT_VALUE_2 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(2,"Lập Trình Web","3-6","303","07CNTT7","2022-01-24",1)
    ''';
  static const INSERT_VALUE_3 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(3,"Lập Trình Web","6-9","303","07CNTT7","2022-01-24",1)
  ''';
  static const INSERT_VALUE_4 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(4,"Lập Trình JAVA","1-3","305","07CNTT1","2022-01-25",1)
  ''';
  static const INSERT_VALUE_5 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(5,"Lập Trình C#","3-6","305","07CNTT1","2022-01-25",1)
  ''';
  static const INSERT_VALUE_6 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(6,"Lập Trình C#","6-9","305","07CNTT1","2022-01-25",1)
  ''';
  static const INSERT_VALUE_7 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(7,"Lập Trình JAVA","9-12","305","07CNTT2","2022-01-25",1)
  ''';
  static const INSERT_VALUE_8 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(8,"Lập Trình JAVA","1-3","305","07CNTT2","2022-01-26",1)
  ''';
  static const INSERT_VALUE_9 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(9,"Quảng Trị Mạng","3-6","303","07CNTT2","2022-01-26",1)
  ''';
  static const INSERT_VALUE_10 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(10,"Lập Trình JAVA","6-9","305","07CNTT1","2022-01-26",1)
  ''';
  static const INSERT_VALUE_11 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(11,"Lập Trình JAVA","9-12","305","07CNTT1","2022-01-26",1)
  ''';
  static const INSERT_VALUE_12 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(12,"Lập Trình Web","1-3","303","07CNTT1","2022-01-27",1)
  ''';
  static const INSERT_VALUE_13 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(13,"Lập Trình Web","3-6","303","07CNTT2","2022-01-27",1)
  ''';
  static const INSERT_VALUE_14 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(14,"Cơ sở dữ liệu","6-9","305","07CNTT1","2022-01-27",1)
  ''';
  static const INSERT_VALUE_15 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(15,"Cơ sở dữ liệu","9-12","305","07CNTT1","2022-01-27",1)
  ''';
  static const INSERT_VALUE_16 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(16,"Cơ sở dữ liệu","1-3","303","07CNTT1","2022-01-28",1)
    ''';
  static const INSERT_VALUE_17 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(17,"Cơ sở dữ liệu","3-6","303","07CNTT1","2022-01-28",1)
  ''';
  static const INSERT_VALUE_18 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(18,"Lập Trình JAVA","6-9","305","07CNTT5","2022-01-28",1)
  ''';
  static const INSERT_VALUE_19 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(19,"Lập Trình JAVA","9-12","305","07CNTT5","2022-01-28",1)
  ''';
  static const INSERT_VALUE_20 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(20,"Lập Trình JAVA","1-3","305","07CNTT3","2022-01-24",2)
  ''';
  static const INSERT_VALUE_21 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(21,"Lập Trình Web","3-6","303","07CNTT5","2022-01-24",2)
    ''';
  static const INSERT_VALUE_22 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(22,"Lập Trình Web","6-9","303","07CNTT5","2022-01-24",2)
  ''';
  static const INSERT_VALUE_23 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(23,"Lập Trình JAVA","1-3","305","07CNTT3","2022-01-25",2)
  ''';
  static const INSERT_VALUE_24 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(24,"Lập Trình C#","3-6","305","07CNTT3","2022-01-25",2)
  ''';
  static const INSERT_VALUE_25 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(25,"Lập Trình C#","6-9","305","07CNTT3","2022-01-25",2)
  ''';
  static const INSERT_VALUE_26 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(26,"Lập Trình JAVA","9-12","305","07CNTT4","2022-01-25",2)
  ''';
  static const INSERT_VALUE_27 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(27,"Lập Trình JAVA","1-3","305","07CNTT4","2022-01-26",2)
  ''';
  static const INSERT_VALUE_28 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(28,"Quảng Trị Mạng","3-6","303","07CNTT4","2022-01-26",2)
  ''';
  static const INSERT_VALUE_29 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(29,"Lập Trình JAVA","6-9","305","07CNTT4","2022-01-26",2)
  ''';
  static const INSERT_VALUE_30 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(30,"Lập Trình JAVA","9-12","305","07CNTT4","2022-01-26",2)
  ''';
  static const INSERT_VALUE_31 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(31,"Lập Trình Web","1-3","303","07CNTT4","2022-01-27",2)
  ''';
  static const INSERT_VALUE_32 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(32,"Lập Trình Web","3-6","303","07CNTT5","2022-01-27",2)
  ''';
  static const INSERT_VALUE_33 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(33,"Cơ sở dữ liệu","6-9","305","07CNTT4","2022-01-27",2)
  ''';
  static const INSERT_VALUE_34 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(34,"Cơ sở dữ liệu","9-12","305","07CNTT4","2022-01-27",2)
  ''';
  static const INSERT_VALUE_35 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(35,"Cơ sở dữ liệu","1-3","303","07CNTT4","2022-01-28",2)
    ''';
  static const INSERT_VALUE_36 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(36,"Cơ sở dữ liệu","3-6","303","07CNTT4","2022-01-28",2)
  ''';
  static const INSERT_VALUE_37 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(37,"Lập Trình JAVA","6-9","305","07CNTT6","2022-01-28",2)
  ''';
  static const INSERT_VALUE_38 ='''
    INSERT INTO calendar(id,name,title,room,clas,date,idUser) VALUES(38,"Lập Trình JAVA","9-12","305","07CNTT6","2022-01-28",2)
  ''';


  Future<List<Calendar>> selectEventCalendar() async{
    final Database? db = DB.instance.database;
    final List<Map<String,dynamic>> maps = await db!.query('calendar');
    return maps.map((e) => Calendar.fromMap(e)).toList();
  }
  Future<List<Calendar>> selectEventCalendar1(int id) async{
    final Database? db = DB.instance.database;
    final List<Map<String,dynamic>> maps = await db!.query('calendar where idUser="$id"');
    return maps.map((e) => Calendar.fromMap(e)).toList();
  }
  Future<List<Calendar>> retrieveEvents(String date,int iduser) async {
    final Database? db = DB.instance.database;
    final List<Map<String, Object?>> maps =
    await db!.rawQuery('select * from calendar where date=? and idUser=?', [date,iduser]);
    return maps.map((e) => Calendar.fromMap(e)).toList();
  }
}