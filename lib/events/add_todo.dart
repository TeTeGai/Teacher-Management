import 'package:cnpm/base/base_event.dart';

class AddNewsEvent extends BaseEvent{
  int id;
  String title;
  String img;
  AddNewsEvent(this.id,this.title,this.img);
}
class AddDetailsEvent extends BaseEvent{
  int id;
  String title;
  String img1;
  String img2;
  String text1;
  String text2;
  AddDetailsEvent(this.id,this.title,this.img1,this.img2,this.text1,this.text2);
}
class AddBunghisEvent extends BaseEvent{
   int id;
   String name;
   String title;
   String room;
   String clas;
   String date;
   int idUser;
   String lydo;

   AddBunghisEvent(this.id, this.name, this.title, this.room, this.clas,
      this.date, this.idUser, this.lydo);
}

class AddBaobusEvent extends BaseEvent{
  int id;
  String name;
  String title;
  String room;
  String clas;
  String date;
  int idUser;
  int cate;
  String titlebu;
  String datebu;

  AddBaobusEvent(this.id, this.name, this.title, this.room, this.clas,
      this.date, this.idUser, this.cate, this.titlebu, this.datebu);
}

class AddSaiphamEvent extends BaseEvent{
  int id;
  String name;
  String title;
  String room;
  String clas;
  String date;
  int idUser;
  String desc;
  String sp;
  String namett;
  String nameuser;
  AddSaiphamEvent(this.id, this.name, this.title, this.room, this.clas,
      this.date, this.idUser, this.desc, this.sp,this.namett,this.nameuser);
}