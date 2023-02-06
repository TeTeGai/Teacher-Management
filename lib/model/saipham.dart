class SaiPham{
  late int _id;
  late String _name;
  late String _title;
  late String _room;
  late String _clas;
  late String _date;
  late int _idUser;
  late String _desc;
  late String _sp;
  late String _namett;
  late String _nameuser;

  SaiPham.fromMap(Map<String, dynamic> res)
      : _id = res['id'],
        _name=res['name'],
        _title=res['title'],
        _room=res['room'],
        _clas=res["clas"],
        _date=res['date'],
        _idUser=res['idUser'],
        _desc=res['desc'],
        _sp=res['sp'],
        _namett=res['namett'],
        _nameuser=res['nameuser']
  ;



  SaiPham.fromData(id,name,title,room,clas,date,idUser,desc,sp,namett,nameuser)
  {
    _id=id;
    _name=name;
    _title=title;
    _room=room;
    _clas=clas;
    _date=date;
    _idUser=idUser;
    _desc=desc;
    _sp=sp;
    _namett=namett;
    _nameuser=nameuser;
  }


  String get nameuser => _nameuser;

  set nameuser(String value) {
    _nameuser = value;
  }

  String get namett => _namett;

  set namett(String value) {
    _namett = value;
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


  String get desc => _desc;

  set desc(String value) {
    _desc = value;
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
      'desc':_desc,
      'sp':_sp,
      'namett':_namett,
      'nameuser':_nameuser
    };
  }

  String get sp => _sp;

  set sp(String value) {
    _sp = value;
  }
}