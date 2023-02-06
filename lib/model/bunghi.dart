class Bunghi{
  late int _id;
  late String _name;
  late String _title;
  late String _room;
  late String _clas;
  late String _date;
  late int _idUser;
  late String _lydo;




  Bunghi.fromMap(Map<String, dynamic> res)
      : _id = res['id'],
        _name=res['name'],
        _title=res['title'],
        _room=res['room'],
        _clas=res["clas"],
        _date=res['date'],
        _idUser=res['idUser'],
        _lydo=res['lydo'];


  Bunghi.fromData(id,name,title,room,clas,date,idUser,lydo)
  {
    _id=id;
    _name=name;
    _title=title;
    _room=room;
    _clas=clas;
    _date=date;
    _idUser=idUser;
    _lydo=lydo;
  }



  int get idUser => _idUser;

  set idUser(int value) {
    _idUser = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get clas => _clas;

  set clas(String value) {
    _clas = value;
  }

  String get room => _room;

  set room(String value) {
    _room = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }


  String get lydo => _lydo;

  set lydo(String value) {
    _lydo = value;
  }

  Map<String,dynamic> toMap()
  {
    return{
      'id':_id,
      'name':_name,
      'title':_title,
      'room':_room,
      'clas':_clas,
      'date':_date,
      'idUser':_idUser,
      'lydo':_lydo,
    };
  }

}