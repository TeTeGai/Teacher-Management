
import 'package:cnpm/model/bunghi.dart';
import 'package:cnpm/model/login.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';

class LoginTable{

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

  static const TABLE_NAME= 'login';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME(
    id INTEGER PRIMARY KEY,
    username TEXT,
    pass TEXT,
    user TEXT,
    namedisplay TEXT
    );
  ''';
  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';
  static const INSERT_VALUE_1 ='''
    INSERT INTO login(id,username,pass,user,namedisplay) VALUES(1,"thanh20ntt","Nitobe123","Giảng viên","Ngô Trường Thanh")
  ''';
  static const INSERT_VALUE_2 ='''
     INSERT INTO login(id,username,pass,user,namedisplay) VALUES(2,"thanh21ntt","Nitobe123","Giảng viên","Trần Trí Trung")
  ''';
  static const INSERT_VALUE_3 ='''
     INSERT INTO login(id,username,pass,user,namedisplay) VALUES(3,"admin","123","Thanh tra","ADMIN1")
  ''';
  static const INSERT_VALUE_4 ='''
     INSERT INTO login(id,username,pass,user,namedisplay) VALUES(4,"admin2","123","Thanh tra","ADMIN2")
  ''';

  Future<List<Login>> selectEventLogin() async{
    final Database? db = DB.instance.database;
    final List<Map<String,dynamic>> maps = await db!.query('login where user = "Giảng viên"');
    return maps.map((e) => Login.fromMap(e)).toList();
  }

  Future<List<Login>> selectUser(int id) async{
    final Database? db = DB.instance.database;
    final List<Map<String,dynamic>> maps = await db!.query('login where id = "$id"');
    return maps.map((e) => Login.fromMap(e)).toList();
  }
  Future<Login?> loginEvents(String username,String pass) async {
    final Database? db = DB.instance.database;
    var res =await db!.rawQuery('SELECT * FROM login WHERE username="$username" and pass = "$pass" ');
    if (res.length > 0) {
      return new Login.fromMap(res.first);
    }
    return null;
  }
  Future<void> updateUser(String pass,int id) async{
    final Database? db = DB.instance.database;
    final  maps = await db!.rawUpdate('update login set pass = "$pass" where id= "$id"');

  }

  Future role(String username,String pass) async {
    final Database? db = DB.instance.database;
    var res =await db!.rawQuery('SELECT user FROM login WHERE username="$username" and pass = "$pass" LIMIT 1');
    return res.toString();
  }

  Future loginEvents1(String username,String pass) async {
    final Database? db = DB.instance.database;
    var res =await db!.rawQuery('SELECT user FROM login WHERE username="$username" and pass = "$pass" ');
    if (res.length > 0) {
      return new Login.fromMap(res.first);
    }
    return null;
  }
}
