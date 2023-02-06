
import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/home.dart';
import 'package:cnpm/model/login.dart';
import 'package:cnpm/widgets/account/account_page.dart';
import 'package:cnpm/widgets/bunghi/bunghi_list_container.dart';
import 'package:cnpm/widgets/calendar/calendar_list.dart';
import 'package:cnpm/widgets/login2/login_form.dart';
import 'package:cnpm/widgets/news/news_container.dart';
import 'package:cnpm/widgets/news/news_page.dart';
import 'package:cnpm/widgets/saipham/saipham_list_container.dart';
import 'package:cnpm/widgets/thanhtra/Thanhtrahome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'db/db.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.instance.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? id = prefs.getInt("id");
  String? user = prefs.getString("user");
  print(id);

  if(user=="Giảng viên")
    {
      runApp(
          MaterialApp(debugShowCheckedModeBanner: false,
            home: id == null ? LoginForm() : Home(),));
    }
  else
    {
      runApp(
          MaterialApp(debugShowCheckedModeBanner: false,
            home: id == null ? LoginForm() : ThanhtraHome(),));
    }

}
class Myapp extends StatefulWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(

          body: Provider<Bloc>.value(
              value: Bloc(),
              // child: _chil[_currentIndex]
            child: LoginForm(),
            // child: AccountPage(),

          )
          ,
         ),

    );
  }
}
