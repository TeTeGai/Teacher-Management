
import 'package:cnpm/model/bunghi.dart';
import 'package:cnpm/model/saipham.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';

class SaiphamTable{
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

  static const TABLE_NAME= 'saipham';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME(
    id INTEGER PRIMARY KEY,
    name TEXT,
    title TEXT,
    room TEXT,
    clas TEXT,
    date TEXT,
    idUser INTEGER,
    desc TEXT,
    sp TEXT,
    nameuser TEXT,
    namett TEXT
    );
  ''';
  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';
  static const INSERT_VALUE_1 ='''
    INSERT INTO saipham(id,name,title,room,clas,date,idUser,desc,sp) VALUES(1,"10","10","10","10","2021-12-28",1,"1","1")
  ''';
  static const INSERT_VALUE_2 ='''
    INSERT INTO saipham(id,name,title,room,clas,date,idUser,desc,sp) VALUES(2,"20","20","20","20","2021-12-27",2,"2","2")
  ''';

  Future<List<SaiPham>> selectEventSaiPham(int iduser) async{
    final Database? db = DB.instance.database;
    final List<Map<String,dynamic>> maps = await db!.query('saipham where idUser= "$iduser"');
    return maps.map((e) => SaiPham.fromMap(e)).toList();
  }

  Future<List<SaiPham>> selectEventPhanHoi(String namett) async{
    final Database? db = DB.instance.database;
    final List<Map<String,dynamic>> maps = await db!.query('saipham where namett = "$namett" and sp =0');
    return maps.map((e) => SaiPham.fromMap(e)).toList();
  }

  Future<int> insertSaiPham(SaiPham saiPham)
  {
    final Database? db = DB.instance.database;
    return db!.insert(
      TABLE_NAME,
      saiPham.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,);
  }
  Future<void> updateSaiPham(String desc,int id,String username, String tt) async{
    final Database? db = DB.instance.database;
    final  maps = await db!.rawUpdate('update saipham set desc = "$desc", nameuser = "$username", sp="$tt" where id= "$id"');
  }
}