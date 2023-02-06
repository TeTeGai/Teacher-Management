import 'package:cnpm/model/details.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';

class DetailsTable{
  static const TABLE_NAME= 'details';
  static const CREATE_TABLE_QUERY = '''
    CREATE TABLE $TABLE_NAME(
    id INTEGER PRIMARY KEY,
    title TEXT,
    time TEXT,
    img1 TEXT,
    img2 TEXT,
    text1 TEXT,
    text2 TEXT,
    idnews INTEGER
    );
  ''';
  static const DROP_TABLE_QUERY = '''
    DROP TABLE IF EXISTS $TABLE_NAME
  ''';
  static const INSERT_VALUE_1 ='''
    INSERT INTO details(id,title,time,img1,img2,text1,text2,idnews) 
    VALUES(
    1,
    "HỘI THẢO TẬP HUẤN VỀ SỞ HỮU TRÍ TUỆ VÀ CHUYỂN GIAO CÔNG NGHỆ",
    "24/12/2021",
    "https://musicandroidmp3thanh.000webhostapp.com/News/Dimg1.jpg",
    "https://musicandroidmp3thanh.000webhostapp.com/News/Dimg2.jpg",
    "Nằm trong chuỗi hoạt động kỷ niệm 45 năm hình thành - phát triển, 10 năm thành lập Trường đại học và đón nhận Huân chương Lao động hạng Nhì của Trường Đại học Tài nguyên và Môi trường Thành phố Hồ Chí Minh. Hôm nay ngày 24/12/2021, Trường Đại học Tài nguyên và Môi trường Thành phố Hồ Chí Minh trân trọng tổ chức hội thảo với chủ đề “Tập huấn về Sở hữu trí tuệ và Chuyển giao công nghệ’’. Với mong muốn bức tranh và góc nhìn về Sở hữu trí tuệ (SHTT) và Chuyển giao công nghệ (CGCN) trở nên gần gũi hơn cho các Thầy cô, nhà Nghiên cứu, về việc làm sao chuyển các kết quả Nghiên cứu thành SHTT và có thể CGCN trong thực tiễn. Hội thảo được diễn ra trực tiếp tại Phòng họp B và trực tuyến qua nền tảng zoom.",
    "Phát biểu khai mạc Hội thảo, PGS. TS. Huỳnh Quyền - Hiệu trưởng Nhà trường nhấn mạnh tầm quan trọng của luật sở hữu trí tuệ, hoạt động sở hữu trí tuệ trong chuyển giao khoa học công nghệ tại các trường đại học, Viên nghiên cứu. Chính vì vậy, các nội dung của hội thảo tập huấn có ý nghĩa rất quan trọng đối với tập thể cán bộ giảng viên, đặc biệt là khi sản phẩm nghiên cứu được thương mại hóa cần được sự bảo hộ của pháp luật.",
    1)
  ''';
  static const INSERT_VALUE_2 ='''
    INSERT INTO details(id,title,time,img1,img2,text1,text2,idnews) 
    VALUES(
    2,
    "Hội nghị Khoa học Công nghệ lần thứ 5 của Trường Đại học Tài nguyên và Môi trường Thành phố Hồ Chí Minh",
    "26/11/2021",
    "https://musicandroidmp3thanh.000webhostapp.com/News/Dimg1.jpg",
    "https://musicandroidmp3thanh.000webhostapp.com/News/Dimg2.jpg",
    "Nằm trong chuỗi hoạt động chào mừng Kỷ niệm 45 năm hình thành-phát triển (1976-2021), 10 năm thành lập trường đại học và đón nhận Huân chương Lao động hạng Nhì của Trường Đại học Tài nguyên và Môi trường Thành phố Hồ Chí Minh. Theo kế hoạch Khoa học công nghệ thường niên, hôm nay ngày 26/11/2021 Trường Đại học Tài nguyên và Môi trường Thành phố Hồ Chí Minh tổ chức Hội nghị khoa học công nghệ lần thứ 5 với Chủ đề: “Quản lý Tài nguyên và môi trường hướng đến phát triển bền vững trong thời kỳ Cách mạng công nghiệp 4.0”. Hội nghị được diễn ra trực tiếp tại Hội trường A và trực tuyến tại các điểm cầu Hà Nội, qua nền tảng zoom và phát trực tuyến trên kênh fanpage của trường.",
    "Tại điểm cầu Hội trường A Trường Đại học Tài nguyên và Môi trường TP. HCM đến dự có sự hiện diện của PGS. TS. Vũ Xuân Cường - Bí thư Đảng ủy, Chủ tịch Hội đồng Trường, PGS. TS. Huỳnh Quyền - Phó Bí thư Đảng ủy, Hiệu trưởng Nhà trường. Cùng toàn thể các Thầy Cô là giảng viên, các nhà khoa học, Trưởng/Phó các Khoa/Bộ môn chuyên ngành và các em học viên, sinh viên Nhà trường tham dự trực tiếp và trực tuyến Hội nghị ngày hôm nay. Đến dự Hội nghị hôm nay còn có sự hiện diện của Ông Trần Việt Dũng - Phó Bí thư Đảng ủy khối cơ sở Bộ Tài nguyên và Môi trường; đại diện các đơn vị, các công ty đối tác và các đại biểu tham dự qua nền tảng trực tuyến.",
    2)
  ''';

  Future<int> insertDetails(Details details)
  {
    final Database? db = DB.instance.database;
    return db!.insert(
      TABLE_NAME,
      details.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  Future<void> deleDetails(Details details)
  async {
    final Database? db = DB.instance.database;
    await db!.delete(
        TABLE_NAME,
        where: 'id=?',
        whereArgs: [details.id]
    );
  }
  // Future<List<Details>> selectAllDetails() async{
  //   final Database? db = DB.instance.database;
  //   final List<Map<String,dynamic>> maps = await db!.query('details');
  //   return List.generate(maps.length, (index) {
  //     return Details.fromData(
  //         maps[index]['id'],
  //         maps[index]['title'],
  //         maps[index]['img1'],
  //         maps[index]['img2'],
  //         maps[index]['text1'],
  //         maps[index]['text2'],
  //         maps[index]['idnews']
  //     );
  //   });
  // }

  Future<List<Details>> selectEventDetails(int idnews) async{
    final Database? db = DB.instance.database;
    final List<Map<String,dynamic>> maps = await db!.query('details WHERE idnews="$idnews"');
    return maps.map((e) => Details.fromMap(e)).toList();
  }
}