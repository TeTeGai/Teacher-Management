import 'dart:async';
import 'dart:math';

import 'package:cnpm/base/base_bloc.dart';
import 'package:cnpm/base/base_event.dart';
import 'package:cnpm/db/baobu_table.dart';
import 'package:cnpm/db/bunghi_table.dart';
import 'package:cnpm/db/calendar_table.dart';
import 'package:cnpm/db/details_table.dart';
import 'package:cnpm/db/login_table.dart';
import 'package:cnpm/db/news_table.dart';
import 'package:cnpm/db/saipham_table.dart';
import 'package:cnpm/events/add_todo.dart';
import 'package:cnpm/model/baonghi.dart';
import 'package:cnpm/model/bunghi.dart';
import 'package:cnpm/model/calendar.dart';
import 'package:cnpm/model/details.dart';
import 'package:cnpm/model/login.dart';
import 'package:cnpm/model/news.dart';
import 'package:cnpm/model/saipham.dart';
import 'package:flutter/cupertino.dart';



class Bloc extends BaseBloc{
  NewsTable _newsTable = new NewsTable();
  StreamController<List<News>> _NewsListStreamContronller = StreamController<List<News>>();
  Stream<List<News>> get newslistStream => _NewsListStreamContronller.stream;
  List<News> _newslist = <News>[];

  DetailsTable _detailsTable = new DetailsTable();
  StreamController<List<Details>> _DetailsListStreamContronller = StreamController<List<Details>>();
  Stream<List<Details>> get detailslistStream => _DetailsListStreamContronller.stream;
  List<Details> _detailslist = <Details>[];

  CalendarTable _calendarTable = new CalendarTable();
  StreamController<List<Calendar>> _CalendarListStreamContronller = StreamController<List<Calendar>>();
  Stream<List<Calendar>> get calendarlistStream => _CalendarListStreamContronller.stream;
  List<Calendar> _calendarlist = <Calendar>[];

  BunghiTable _bunghiTable = new BunghiTable();
  StreamController<List<Bunghi>> _BunghiListStreamContronller = StreamController<List<Bunghi>>();
  Stream<List<Bunghi>> get bunghilistStream => _BunghiListStreamContronller.stream;
  List<Bunghi> _bunghilist = <Bunghi>[];

  BaoBuTable _baobuTable = new BaoBuTable();
  StreamController<List<Baobu>> _BaobuListStreamContronller = StreamController<List<Baobu>>();
  Stream<List<Baobu>> get baobulistStream => _BaobuListStreamContronller.stream;
  List<Baobu> _baobulist = <Baobu>[];

  SaiphamTable _saiphamTable = new SaiphamTable();
  StreamController<List<SaiPham>> _SaiphamListStreamContronller = StreamController<List<SaiPham>>();
  Stream<List<SaiPham>> get saiphamlistStream => _SaiphamListStreamContronller.stream;
  List<SaiPham> _saiphamlist = <SaiPham>[];

  LoginTable _loginTable = new LoginTable();
  StreamController<List<Login>> _LoginListStreamContronller = StreamController<List<Login>>();
  Stream<List<Login>> get loginlistStream => _LoginListStreamContronller.stream;
  List<Login> _loginlist = <Login>[];

  userDataAdmin() async {
    _loginlist = await _loginTable.selectEventLogin();
    _LoginListStreamContronller.sink.add(_loginlist);
    if(_loginlist == null)
    {
      return Text("data ko co");
    }
  }
  userData(int id) async {
    _loginlist = await _loginTable.selectUser(id);
    _LoginListStreamContronller.sink.add(_loginlist);
    if(_loginlist == null)
    {
      return Text("data ko co");
    }
  }
  initData() async {
    _newslist = await _newsTable.selectAllNews();
    _NewsListStreamContronller.sink.add(_newslist);
    if(_newslist == null)
    {
      return Text("data ko co");
    }
  }

  detailsData(int idnews) async {
    _detailslist = await _detailsTable.selectEventDetails(idnews);
    _DetailsListStreamContronller.sink.add(_detailslist);
    if(_detailslist == null)
    {
      return Text("data ko co");
    }
  }

  bunghiData(iduser) async {
    _bunghilist = await _bunghiTable.selectEventCalendar(iduser);
    _BunghiListStreamContronller.sink.add(_bunghilist);
    if(_bunghilist == null)
    {
      return Text("data ko co");
    }
  }

  baobuData(iduser) async {
    _baobulist = await _baobuTable.selectBaobu(iduser);
    _BaobuListStreamContronller.sink.add(_baobulist);
    if(_bunghilist == null)
    {
      return Text("data ko co");
    }
  }

  saiphamData(int iduser) async {
    _saiphamlist = await _saiphamTable.selectEventSaiPham(iduser);
    _SaiphamListStreamContronller.sink.add(_saiphamlist);
    if(_saiphamlist == null)
    {
      return Text("data ko co");
    }
  }
  calendarData(String date,int iduser) async {
    _calendarlist = await _calendarTable.retrieveEvents(date,iduser);
    _CalendarListStreamContronller.sink.add(_calendarlist);
    if(_calendarlist == null)
    {
      return Text("data ko co");
    }
  }

  // _updateAC(String pass, int id) async {
  //   await _loginTable.updateUser(pass,id);
  //
  //   _loginlist.(news);
  //   _LoginListStreamContronller.sink.add(_newslist);
  // }
  _addNews(News news) async {
    await _newsTable.insertNews(news);

    _newslist.add(news);
    _NewsListStreamContronller.sink.add(_newslist);
  }
  _delete(News news) async {
    await _newsTable.deleNews(news);
    _newslist.remove(news);
    _NewsListStreamContronller.sink.add(_newslist);
  }

  _addDetails(Details details) async {
    await _detailsTable.insertDetails(details);

    _detailslist.add(details);
    _DetailsListStreamContronller.sink.add(_detailslist);
  }
  _deleteDetails(Details details) async {
    await _detailsTable.deleDetails(details);
    _detailslist.remove(details);
    _DetailsListStreamContronller.sink.add(_detailslist);
  }

  _addBunghi(Bunghi bunghi) async {

    await _bunghiTable.insertBunghi(bunghi);
    _bunghilist.add(bunghi);
    _BunghiListStreamContronller.sink.add(_bunghilist);
  }
  _addBaobu(Baobu baobu) async {

    await _baobuTable.insertBaobu(baobu);
    _baobulist.add(baobu);
    _BaobuListStreamContronller.sink.add(_baobulist);
  }
  _addSaipham(SaiPham saiPham) async {

    await _saiphamTable.insertSaiPham(saiPham);
    _saiphamlist.add(saiPham);
    _SaiphamListStreamContronller.sink.add(_saiphamlist);
  }
  @override
  void dispatchEvent(BaseEvent baseEvent) {

     if(baseEvent is AddBunghisEvent) {
       Bunghi bunghi  = Bunghi.fromData(
        baseEvent.id,
        baseEvent.name,
        baseEvent.title,
        baseEvent.room,
        baseEvent.clas,
        baseEvent.date,
        baseEvent.idUser,
        baseEvent.lydo,
    );
      _addBunghi(bunghi);
    }
     else if(baseEvent is AddBaobusEvent) {
       Baobu baobu  = Baobu.fromData(
         baseEvent.id,
         baseEvent.name,
         baseEvent.title,
         baseEvent.room,
         baseEvent.clas,
         baseEvent.date,
         baseEvent.idUser,
         baseEvent.cate,
         baseEvent.titlebu,
         baseEvent.datebu,
       );
       _addBaobu(baobu);
     }
    else if(baseEvent is AddSaiphamEvent) {
      SaiPham saiPham  = SaiPham.fromData(
        baseEvent.id,
        baseEvent.name,
        baseEvent.title,
        baseEvent.room,
        baseEvent.clas,
        baseEvent.date,
        baseEvent.idUser,
        baseEvent.desc,
        baseEvent.sp,
        baseEvent.namett,
        baseEvent.nameuser
      );
      _addSaipham(saiPham);
    }
  }






  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _NewsListStreamContronller.close();
  }

}