
import 'package:cnpm/model/baonghi.dart';
import 'package:cnpm/model/bunghi.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';

class BaoBuTable{
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

  static const TABLE_NAME= 'baobu';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME(
    id INTEGER PRIMARY KEY,
    name TEXT,
    title TEXT,
    room TEXT,
    clas TEXT,
    date TEXT,
    idUser INTEGER,
    cate INTEGER,
    titlebu TEXT,
    datebu TEXT
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

  Future<List<Baobu>> selectBaobu(iduser) async{
    final Database? db = DB.instance.database;
    final List<Map<String,dynamic>> maps = await db!.query('baobu where idUser= "$iduser"');
    return maps.map((e) => Baobu.fromMap(e)).toList();
  }

  Future<int> insertBaobu(Baobu baobu)
  {
    final Database? db = DB.instance.database;
    return db!.insert(
      TABLE_NAME,
      baobu.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,);
  }
}