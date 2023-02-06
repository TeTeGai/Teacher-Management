
import 'package:cnpm/db/baobu_table.dart';
import 'package:cnpm/db/bunghi_table.dart';
import 'package:cnpm/db/calendar_table.dart';
import 'package:cnpm/db/details_table.dart';
import 'package:cnpm/db/login_table.dart';
import 'package:cnpm/db/news_table.dart';
import 'package:cnpm/db/saipham_table.dart';
import 'package:cnpm/model/saipham.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB{
  static const String DB_NAME = 'cnpm161.db';
  static const DB_VERSION= 1;
  static Database? _database;
  DB._internal();
  static final DB instance = DB._internal();
  Database? get database => _database;
  static const initScripts = [NewsTable.CREATE_TABLE_QUERY,DetailsTable.CREATE_TABLE_QUERY];
  static const migrationScripts = [NewsTable.CREATE_TABLE_QUERY,DetailsTable.CREATE_TABLE_QUERY];
  static const NewsValue = [NewsTable.INSERT_VALUE_1,NewsTable.INSERT_VALUE_2,NewsTable.INSERT_VALUE_3,NewsTable.INSERT_VALUE_4];
  static const CalendarValue = [CalendarTable.INSERT_VALUE_1,CalendarTable.INSERT_VALUE_2,
    CalendarTable.INSERT_VALUE_3,CalendarTable.INSERT_VALUE_4,CalendarTable.INSERT_VALUE_5,
    CalendarTable.INSERT_VALUE_6,CalendarTable.INSERT_VALUE_7, CalendarTable.INSERT_VALUE_8,
    CalendarTable.INSERT_VALUE_9, CalendarTable.INSERT_VALUE_10,
    CalendarTable.INSERT_VALUE_11, CalendarTable.INSERT_VALUE_12,CalendarTable.INSERT_VALUE_13,
    CalendarTable.INSERT_VALUE_14,CalendarTable.INSERT_VALUE_15, CalendarTable.INSERT_VALUE_16,
    CalendarTable.INSERT_VALUE_17, CalendarTable.INSERT_VALUE_18,CalendarTable.INSERT_VALUE_19,
    CalendarTable.INSERT_VALUE_20,CalendarTable.INSERT_VALUE_21,CalendarTable.INSERT_VALUE_22,
    CalendarTable.INSERT_VALUE_23,CalendarTable.INSERT_VALUE_24,CalendarTable.INSERT_VALUE_25,
    CalendarTable.INSERT_VALUE_26,CalendarTable.INSERT_VALUE_27, CalendarTable.INSERT_VALUE_28,
    CalendarTable.INSERT_VALUE_29,CalendarTable.INSERT_VALUE_30, CalendarTable.INSERT_VALUE_31,
    CalendarTable.INSERT_VALUE_32, CalendarTable.INSERT_VALUE_33,CalendarTable.INSERT_VALUE_34,
    CalendarTable.INSERT_VALUE_35,CalendarTable.INSERT_VALUE_36,CalendarTable.INSERT_VALUE_37,CalendarTable.INSERT_VALUE_38,
  ];
  static const BunghiValue = [BunghiTable.INSERT_VALUE_1,BunghiTable.INSERT_VALUE_2];
  static const SaiPhamValue = [SaiphamTable.INSERT_VALUE_1,SaiphamTable.INSERT_VALUE_2];
  static const LoginValue = [LoginTable.INSERT_VALUE_1,LoginTable.INSERT_VALUE_2,LoginTable.INSERT_VALUE_3,LoginTable.INSERT_VALUE_4];
  static const DetailsValue = [DetailsTable.INSERT_VALUE_1,DetailsTable.INSERT_VALUE_2];
  // static const migrationScripts = [NewsTable.CREATE_TABLE_QUERY];

  init() async {
    _database = await openDatabase(
        join(await getDatabasesPath(),DB_NAME),
        version: 2,
        onCreate: (db,version) async {
          // initScripts.forEach((element) async=> await db.execute(element));
          await db.execute(NewsTable.CREATE_TABLE_QUERY);
          await db.execute(DetailsTable.CREATE_TABLE_QUERY);
          await db.execute(CalendarTable.CREATE_TABLE_QUERY);
          await db.execute(BunghiTable.CREATE_TABLE_QUERY);
          await db.execute(SaiphamTable.CREATE_TABLE_QUERY);
          await db.execute(LoginTable.CREATE_TABLE_QUERY);
          await db.execute(BaoBuTable.CREATE_TABLE_QUERY);
          NewsValue.forEach((element) async=> await db.rawInsert(element));
          CalendarValue.forEach((element) async=> await db.rawInsert(element));
          LoginValue.forEach((element) async=> await db.rawInsert(element));
          DetailsValue.forEach((element) async=> await db.rawInsert(element));
          // SaiPhamValue.forEach((element) async=> await db.rawInsert(element));
          // BunghiValue.forEach((element) async=> await db.rawInsert(element));

        },
        onUpgrade: (db, olVersion, newVersion) async {
          await db.execute(NewsTable.CREATE_TABLE_QUERY);
          await db.execute(DetailsTable.CREATE_TABLE_QUERY);
          await db.execute(CalendarTable.CREATE_TABLE_QUERY);
          await db.execute(BunghiTable.CREATE_TABLE_QUERY);
          await db.execute(SaiphamTable.CREATE_TABLE_QUERY);
          await db.execute(LoginTable.CREATE_TABLE_QUERY);
          await db.execute(BaoBuTable.CREATE_TABLE_QUERY);
          NewsValue.forEach((element) async=> await db.rawInsert(element));
          CalendarValue.forEach((element) async=> await db.rawInsert(element));
          LoginValue.forEach((element) async=> await db.rawInsert(element));
          DetailsValue.forEach((element) async=> await db.rawInsert(element));
          // SaiPhamValue.forEach((element) async=> await db.rawInsert(element));
          // BunghiValue.forEach((element) async=> await db.rawInsert(element));
        },


    );
  }
}