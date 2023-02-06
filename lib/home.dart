
import 'package:cnpm/widgets/account/account_page.dart';
import 'package:cnpm/widgets/account/updateaccount_page.dart';
import 'package:cnpm/widgets/baobu/baobu_list_container.dart';
import 'package:cnpm/widgets/bunghi/bunghi_list_container.dart';
import 'package:cnpm/widgets/calendar/calendar_list.dart';
import 'package:cnpm/widgets/login2/login_form.dart';
import 'package:cnpm/widgets/news/news_page.dart';
import 'package:cnpm/widgets/saipham/saipham_list_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_button.dart';
import 'bloc/bloc.dart';
import 'db/login_table.dart';
import 'model/login.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late  int id;
  late String pass;
  String name ='';
  String user ='';
  int _currentIndex = 0;
  late LoginTable dataBaseHelper;
  List<Login> eventsList = [];
   PageController? _pageController ;
  loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt("id")!;
      pass =prefs.getString("pass")!;
      name =prefs.getString("namedisplay")!;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.dataBaseHelper= LoginTable();
    loadCounter();
    _pageController = PageController(initialPage: _currentIndex);
    this.dataBaseHelper.initializeDB().whenComplete(() async {
      dataBaseHelper.selectUser(id).then((value) => {
        setState(() {
          eventsList = value;

        })
      });
    });
  }

  final List<Widget> _chil = [
    NewsPage(),
    Calendarlist(),
    Bunghi_container(),
    Baobu_container(),
    SaiphamContainer(),
  ];
  final List _tit = [
    "Trang chủ","Lịch khóa biểu","Thời gian nghỉ","Thời gian bù","Sai phạm giảng dạy","Tài khoản"
  ];
  void ontapBotbar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  void onTabTapped(int index) {
    this._pageController!.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
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
          drawer: Drawer(

            child: Container(
              color: Colors.blue,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 70),
                    child: Text(name,style: TextStyle(fontSize: 50,color: Colors.white),),
                  ),
                  app_button(label: "Đổi mật khẩu", onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return UpdateACPage(id,pass);
                    }));
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  app_button(label: "Đăng xuất", onTap: () async {


                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('id');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext ctx) => LoginForm()));
                  }),
                  SizedBox(height: 20,),


                ],
              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            title:  Text(_tit[_currentIndex]),
          ),
          body: Provider<Bloc>.value(
            value: Bloc(),
            child: PageView(
              children: _chil,

              onPageChanged: ontapBotbar,
              controller: _pageController,
            )


          ),

          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Trang chủ",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: "Lịch",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.class_),
                label: "Lịch nghỉ",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event),
                label: "Lịch bù",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.work_outlined),
                label: "Sai phạm",
              ),
            ],
          )),

    );
  }
}
