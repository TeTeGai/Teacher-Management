class Details{
  late int _id;
  late String _title;
  late String _time;
  late String _img1;
  late String _img2;
  late String _text1;
  late String _text2;
  late int _idnews;

  Details.fromData(id,img1,img2,text1,text2,title,idnews,time)
  {
    _id =id;
    _title=title;

    _img1=img1;
    _img2=img2;
    _text1=text1;
    _text2=text2;
    _idnews=idnews;
  }
  Details.fromMap(Map<String, dynamic> res)
      : _id = res['id'],
        _title=res['title'],
        _time=res['time'],
        _img1=res['img1'],
        _img2=res["img2"],
        _text1=res['text1'],
        _text2=res['text2'],
        _idnews=res['idnews'];


  int get idnews => _idnews;

  set idnews(int value) {
    _idnews = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  Map<String,dynamic> toMap()
  {
    return{
      'id' :_id,
      'title':_title,
      'img1':_img1,
      'img2':_img2,
      'text1':_text1,
      'text2':_text2,
      'idnews':_idnews
    };
  }

  String get title => _title;

  String get text2 => _text2;

  set text2(String value) {
    _text2 = value;
  }

  String get text1 => _text1;

  set text1(String value) {
    _text1 = value;
  }

  String get img2 => _img2;

  set img2(String value) {
    _img2 = value;
  }

  String get img1 => _img1;

  set img1(String value) {
    _img1 = value;
  }

  set title(String value) {
    _title = value;
  }
}