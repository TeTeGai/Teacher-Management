
import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/login_table.dart';
import 'package:cnpm/model/login.dart';
import 'package:cnpm/widgets/thanhtra/calendar_listAdmin.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homeAdmin.dart';


class ThanhtraContainer extends StatefulWidget {
  String namett;


  ThanhtraContainer(this.namett);

  @override
  _ThanhtraContainerState createState() => _ThanhtraContainerState();
}

class _ThanhtraContainerState extends State<ThanhtraContainer> {
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
    loadCounter();
    this.dataBaseHelper= LoginTable();
    this.dataBaseHelper.initializeDB().whenComplete(() async {
      dataBaseHelper.selectEventLogin().then((value) => {
        setState(() {
          eventsList = value;
        })
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Danh sách giảng viên"),
      ),
      body: ListView.builder(
          itemCount: eventsList.length == 0 ? 0 : eventsList.length,
          itemBuilder: (context, index) {
            return Container(
                child: Column(
                  children: [
                    SizedBox(height:20 ,),
                    DottedBorder(
                        borderType: BorderType.RRect,
                        radius: Radius.circular(0),
                        dashPattern: [10, 10],
                        color: Colors.grey,
                        strokeWidth: 1,
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>Provider<Bloc>.value(
                                        value: Bloc(),
                                        // child: _chil[_currentIndex]
                                        child: HomeAdmin(eventsList[index].id,widget.namett),

                                      )));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.person),
                                    Text("Giảng Viên: "+eventsList[index].nameDisplay,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                                  ],
                                ),
                              ),


                            ],
                          ),
                        )),
                    SizedBox(height:20 ,)
                    // GestureDetector(
                    //   onTap: () {
                    //     // bloc.event.add(DeleteDetailsEvent(snapshot.data![index]));
                    //   },
                    //   child: Icon(
                    //     Icons.delete, color: Colors.red.shade400,),
                    //
                    // ),
                  ],
                )



            );
          }),
    );
  }
}

