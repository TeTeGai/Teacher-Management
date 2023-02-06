import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/login_table.dart';
import 'package:cnpm/model/login.dart';
import 'package:cnpm/widgets/calendar/calendar_list.dart';

import 'package:cnpm/widgets/thanhtra/Thanhtrahome.dart';
import 'package:cnpm/widgets/thanhtra/accounttt_page.dart';
import 'package:cnpm/widgets/thanhtra/thanhtra_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home.dart';
import 'comHelper.dart';
import 'genLoginSignupHeader.dart';
import 'getTextFormField.dart';


class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  String user ='' ;
  late LoginTable dataBaseHelper1;
  var logintable ;

  @override
  void initState() {
    super.initState();
    logintable = LoginTable();
    dataBaseHelper1 = LoginTable();
    this.dataBaseHelper1.initializeDB().whenComplete(() async {
      // dataBaseHelper1.role(id,pass).then((value) => {
      //   setState(() {
      //     user = value;
      //   })
      // });
    });
  }
  // [{user: Thanh tra}]
  login() async {
    String id = _conUserId.text;
    String pass = _conPassword.text;
    await dataBaseHelper1.role(id,pass).then((value) => {
       setState(() {
         user = value;
       })
     });
    if (id.isEmpty) {
      alertDialog(context, "Vui lòng nhập tài khoản");
    } else if (pass.isEmpty) {
      alertDialog(context, "Vui lòng nhập mật khẩu");
    } else if (user =="[{user: Thanh tra}]"){
      await logintable.loginEvents(id,pass).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) {
                  return ThanhtraHome();
                },
                ),
                    (Route<dynamic> route) => false);
            alertDialog1(context, "Đăng nhập thành công");


          });
        } else {
          alertDialog(context, "Tài khoản hoặc mật khẩu bị sai");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Login Fail");
      });
    }
    else if (user =="[{user: Giảng viên}]"){
      await logintable.loginEvents(id, pass).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute( builder: (context)=>Provider<Bloc>.value(
                  value: Bloc(),
                  // child: _chil[_currentIndex]
                  child: Home(),

                )),
                    (Route<dynamic> route) => false);
            alertDialog1(context, "Đăng nhập thành công");
          });
        } else {
          alertDialog(context, "Tài khoản hoặc mật khẩu bị sai");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Login Fail");
      });
    }
    else{
      alertDialog(context, "Tài khoản hoặc mật khẩu bị sai");
    }
    }

  Future setSP(Login login) async {
    final SharedPreferences sp = await _pref;
    sp.setInt("id", login.id);
    sp.setString("username", login.username);
    sp.setString("user", login.user);
    sp.setString("pass", login.pass);
    sp.setString("namedisplay", login.nameDisplay);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Quản lý vi phạm'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                genLoginSignupHeader('Đăng nhập'),
                getTextFormField(
                    controller: _conUserId,
                    icon: Icons.person,
                    hintName: 'Tài khoản'),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Mật khẩu ',
                  isObscureText: true,
                ),
                SizedBox(height: 10.0),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: login,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
