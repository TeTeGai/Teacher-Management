
import 'package:cnpm/model/bunghi.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';

class BunghiTable{
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

  static const TABLE_NAME= 'bunghi';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME(
    id INTEGER PRIMARY KEY,
    name TEXT,
    title TEXT,
    room TEXT,
    clas TEXT,
    date TEXT,
    idUser INTEGER,
    lydo TEXT
    );
  ''';
  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';
  static const INSERT_VALUE_1 ='''
    INSERT INTO bunghi(id,name,title,room,clas,date,idUser,cate) VALUES(1,"10","10","10","10","2021-12-28","1",1)
  ''';
  static const INSERT_VALUE_2 ='''
    INSERT INTO bunghi(id,name,title,room,clas,date,idUser,cate) VALUES(2,"10","10","10","10","2021-12-27","1",0)
  ''';

  Future<List<Bunghi>> selectEventCalendar(iduser) async{
    final Database? db = DB.instance.database;
    final List<Map<String,dynamic>> maps = await db!.query('bunghi where idUser= "$iduser"');
    return maps.map((e) => Bunghi.fromMap(e)).toList();
  }

  Future<int> insertBunghi(Bunghi bunghi)
  {
    final Database? db = DB.instance.database;
    return db!.insert(
      TABLE_NAME,
      bunghi.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,);
  }
}