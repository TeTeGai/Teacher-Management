import 'package:cnpm/db/login_table.dart';
import 'package:cnpm/model/login.dart';
import 'package:cnpm/widgets/login2/comHelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UpdateACPage extends StatefulWidget {
  int id;
  String currentPass;


  UpdateACPage(this.id,this.currentPass);

  @override
  _UpdateACPageState createState() => _UpdateACPageState();
}

class _UpdateACPageState extends State<UpdateACPage> {
  late LoginTable dataBaseHelper;
  late String newPass,oldPass,oldPass1;
  List<Login> eventsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.dataBaseHelper= LoginTable();
    this.dataBaseHelper.initializeDB().whenComplete(() async {
      // setState(() {
      //   dataBaseHelper.updateUser(newPass, widget.id);
      // });
    });
  }
  final oldPassText = TextEditingController();
  final oldPassText1 = TextEditingController();
  final newPassText = TextEditingController();
  @override
  Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
                children: [
                  SizedBox(height: 20,),
                  Text("Đổi mật khẩu tài khoản",style: TextStyle(fontSize: 30),),
                  SizedBox(height: 20,),
                  TextField(
                    obscureText: true,
                    controller: oldPassText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mật khẩu hiện tại',
                    ),
                  ),
                  SizedBox(height: 10,),
                  TextField(
                    obscureText: true,
                    controller: newPassText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Mật khẩu mới',
                    ),

                  ),
                  SizedBox(height: 10,),
                  TextField(
                    obscureText: true,
                    controller: oldPassText1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nhập lại mật khẩu mới',
                    ),
                  ),
                  SizedBox(height: 30,),
                  FlatButton(
                      onPressed: () {
                        if(oldPassText.text.trim().isEmpty)
                      {
                        alertDialog(context, "Chưa nhập lại mật hiện tại");
                      }
                         else if(newPassText.text.trim().isEmpty)
                          {
                            alertDialog(context, "Chưa nhập mật khẩu mới");
                          }
                        else if(oldPassText1.text.trim().isEmpty)
                        {
                          alertDialog(context, "Chưa nhập lại mật khẩu mới");
                        }

                         else if (newPassText.text==oldPassText1.text && oldPassText.text==widget.currentPass)
                         {
                           dataBaseHelper.updateUser(newPassText.text, widget.id);
                           alertDialog1(context, "Đổi mật khẩu thành công");
                           Navigator.pop(context);
                         }
                        else
                          {
                            alertDialog(context, "Lỗi mật khẩu không đúng");
                          }
                      },
                      child: Container(

                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue
                          ),
                          child: Text('Xác nhận',
                            style: TextStyle(color: Colors.white, fontSize: 40),),
                        ),
                      ))
                ],
            ),
          );
    }
  }

