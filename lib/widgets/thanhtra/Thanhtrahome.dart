
import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/login_table.dart';
import 'package:cnpm/model/login.dart';
import 'package:cnpm/widgets/account/account_page.dart';
import 'package:cnpm/widgets/bunghi/bunghi_list_container.dart';
import 'package:cnpm/widgets/calendar/calendar_list.dart';
import 'package:cnpm/widgets/news/news_page.dart';
import 'package:cnpm/widgets/saipham/saipham_list_container.dart';
import 'package:cnpm/widgets/thanhtra/phanhoi_list_container.dart';
import 'package:cnpm/widgets/thanhtra/thanhtra_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'accounttt_page.dart';


class ThanhtraHome extends StatefulWidget {
  const ThanhtraHome({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<ThanhtraHome> {
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Giao diện thanh tra")),
        ),
          body: Provider<Bloc>.value(
            value: Bloc(),
            child: AccountttPage()
          ),
      )

    );
  }
}
