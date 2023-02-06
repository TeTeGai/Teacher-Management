class Login{

  late int _id;
  late String _username;
  late String _pass;
  late String _user;
  late String _nameDisplay;

  Login(this._id, this._username, this._pass, this._user,this._nameDisplay);


  String get nameDisplay => _nameDisplay;

  set nameDisplay(String value) {
    _nameDisplay = value;
  }

  String get user => _user;

  set user(String value) {
    _user = value;
  }

  String get pass => _pass;

  set pass(String value) {
    _pass = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  Login.fromMap( Map<String,dynamic> map)
  {
    _id = map['id'];
    _username = map['username'];
    _pass =map['pass'];
    _user= map['user'];
    _nameDisplay=map['namedisplay'];
  }

  Login.fromData(id,username,pass,user,namedisplay)
  {
    _id=id;
    _username=username;
    _pass=pass;
    _user=user;
    _nameDisplay=namedisplay;
  }
}
