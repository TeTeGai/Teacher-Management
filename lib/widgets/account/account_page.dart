import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/login_table.dart';
import 'package:cnpm/model/login.dart';
import 'package:cnpm/widgets/account/updateaccount_page.dart';
import 'package:cnpm/widgets/login2/login_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  late  int id;
  late LoginTable dataBaseHelper;
  List<Login> eventsList = [];
  loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt("id")!;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.dataBaseHelper= LoginTable();
    loadCounter();
    this.dataBaseHelper.initializeDB().whenComplete(() async {
      dataBaseHelper.selectUser(id).then((value) => {
        setState(() {
          eventsList = value;

        })
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: eventsList.length == 0 ? 0 : eventsList.length,
        itemBuilder: (context, index) {
          return Container(
              child: Column(
                children: [

                  SizedBox(height: 150,),
                  Text("Tên người dùng: "+ eventsList[index].nameDisplay,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  SizedBox(height: 50,),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: ()
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return UpdateACPage(id,eventsList[index].pass);
                        }));
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 3 / 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), color: Colors.blue),
                        child: Center(
                            child: Text(
                              "Đổi mật khẩu",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: RaisedButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('id');
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext ctx) => LoginForm()));
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 3 / 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), color: Colors.grey.shade300),
                        child: Center(
                            child: Text(
                              "Đăng xuất",
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            )),
                      ),
                    ),
                  ),
                ],
              )



          );
        });

  }
}
