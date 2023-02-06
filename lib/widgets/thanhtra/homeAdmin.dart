
import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/widgets/account/account_page.dart';
import 'package:cnpm/widgets/bunghi/bunghi_list_container.dart';

import 'package:cnpm/widgets/news/news_page.dart';
import 'package:cnpm/widgets/saipham/saipham_list_container.dart';
import 'package:cnpm/widgets/thanhtra/baobu_list_container.dart';
import 'package:cnpm/widgets/thanhtra/saipham_list_containerAdmin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bunghi_list_containerAdmin.dart';
import 'calendar_listAdmin.dart';


class HomeAdmin extends StatefulWidget {
  int iduser;
  String namett;


  HomeAdmin(this.iduser,this.namett);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeAdmin> {
  PageController? _pageController ;
   late List<Widget> _chil;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
      _chil = [
      NewsPage(),
      CalendarlistAdmin(widget.iduser,widget.namett),
      BunghiPageAdmin(widget.iduser),
        BaobuPageAdmin(widget.iduser),
      SaiphamPageAdmin(widget.iduser)
    ];
    _pageController = PageController(initialPage: _currentIndex);
  }
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
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
              Navigator.of(context).pop();
              },

            ),
            centerTitle: true,
            title:  Text(_tit[_currentIndex]),
          ),
          body: Provider<Bloc>.value(
            value: Bloc(),
            child:  PageView(
              children: _chil,

              onPageChanged: ontapBotbar,
              controller: _pageController,
            )

          )
          ,
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
