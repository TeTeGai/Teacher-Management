import 'package:cnpm/model/news.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';

class NewsTable{
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

  static const TABLE_NAME= 'news';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME(
    id INTEGER PRIMARY KEY,
    title TEXT,
    img TEXT,
    time TEXT
    );
  ''';
  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';


  static const INSERT_VALUE_1 ='''
    INSERT INTO news(id,title,img,time) VALUES(1,"HỘI THẢO TẬP HUẤN VỀ SỞ HỮU TRÍ TUỆ VÀ CHUYỂN GIAO CÔNG NGHỆ","https://musicandroidmp3thanh.000webhostapp.com/News/News1.jpg","2021-12-24")
  ''';
  static const INSERT_VALUE_2 ='''
    INSERT INTO news(id,title,img,time) VALUES(2,"Hội nghị Khoa học Công nghệ lần thứ 5 của Trường Đại học Tài nguyên và Môi trường Thành phố Hồ Chí Minh","https://musicandroidmp3thanh.000webhostapp.com/News/New2.jpg","2021-11-26")
  ''';
  static const INSERT_VALUE_3 ='''
    INSERT INTO news(id,title,img,time) VALUES(3,"Tuần sinh hoạt công dân năm học 2021 – 2022","https://musicandroidmp3thanh.000webhostapp.com/News/New3.jpg","2021-10-26")
  ''';
  static const INSERT_VALUE_4 ='''
    INSERT INTO news(id,title,img,time) VALUES(4,"Lễ Khai giảng năm học 2021-2022 và chào mừng tất cả các Tân sinh viên khóa 10","https://musicandroidmp3thanh.000webhostapp.com/News/New4.jpg","2021-10-18")
  ''';
  Future<int> insertNews(News news)
  {
    final Database? db = DB.instance.database;
    return db!.insert(
      TABLE_NAME,
      news.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  Future<void> deleNews(News news)
  async {
    final Database? db = DB.instance.database;
    await db!.delete(
        TABLE_NAME,
        where: 'id=?',
        whereArgs: [news.id]
    );
  }
  Future<List<News>> selectAllNews() async{
    final Database? db = DB.instance.database;
    final List<Map<String,dynamic>> maps = await db!.query('news');
    return List.generate(maps.length, (index) {
      return News.fromData(
          maps[index]['id'],
          maps[index]['title'],
          maps[index]['img'],
          maps[index]['time']);
    });
  }
  Future<List<News>> retrieveEvents() async {
    final Database? db = DB.instance.database;
    final List<Map<String, Object?>> maps =
    await db!.rawQuery('select img from news');
    return List.generate(maps.length, (index) {
      return News.fromData(
          maps[index]['id'],
          maps[index]['title'],
          maps[index]['img'],
          maps[index]['time']);
    });
  }
}
