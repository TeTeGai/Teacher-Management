class News{
  late int _id;
  late String _title;
  late String _img;
  late String _time;
  News.fromData(id,title,img,time)
  {
    _id = id;
    _title = title;
    _img=img;
    _time=time;
  }

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get img => _img;

  set img(String value) {
    _img = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Map<String,dynamic> toMap()
  {
    return{
      'id' :_id,
      'title':_title,
      'img':_img,
      'time':_time
    };
  }
}