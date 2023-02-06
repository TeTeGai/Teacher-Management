import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/saipham_table.dart';
import 'package:cnpm/events/add_todo.dart';
import 'package:cnpm/model/saipham.dart';
import 'package:cnpm/widgets/login2/comHelper.dart';
import 'package:cnpm/widgets/thanhtra/phanhoisp.dart';
import 'package:cnpm/widgets/thanhtra/phanhoisp2.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'Thanhtrahome.dart';
import 'accounttt_page.dart';
class PhanhoiContainer extends StatefulWidget {
  String namett;


  PhanhoiContainer(this.namett);

  @override
  _SaiphamContainerState createState() => _SaiphamContainerState();
}

class _SaiphamContainerState extends State<PhanhoiContainer> {

  String disc = '';
  late  int id;
  late SaiphamTable dataBaseHelper;
  List<SaiPham> eventsList = [];
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
    this.dataBaseHelper= SaiphamTable();
    loadCounter();
    this.dataBaseHelper.initializeDB().whenComplete(() async {
      dataBaseHelper.selectEventPhanHoi(widget.namett).then((value) => {
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
        title: Text("Danh sách chờ phản hồi"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context)=>Provider<Bloc>.value(
                  value: Bloc(),
                  child: ThanhtraHome(),
                )),(Route<dynamic> route) => false);
          },

        ),
      ),
      body: Sizer(builder: (context, orientation, deviceType) {
      var bloc = Provider.of<Bloc>(context);
      return ListView.builder(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(Icons.calendar_today),
                                Text("Thời gian: "+eventsList[index].date,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                Text("Tiết: "+eventsList[index].title,style: TextStyle(fontSize: 20,),),
                              ],
                            ),
                            Text("Người nhận xét: "+eventsList[index].nameuser,style: TextStyle(fontSize: 20,),),
                            Text("Ghi chú: "+eventsList[index].desc,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Lớp: "+eventsList[index].clas,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                                SizedBox(width:20 ,),
                                Text("Phòng: "+eventsList[index].room,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 30,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: Text('Chờ kiểm duyệt',style: TextStyle(fontSize: 16,color: Colors.white),),
                                  ),
                                ),

                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=>Provider<Bloc>.value(
                                          value: Bloc(),
                                          child: PhanhoiAdmin(
                                            eventsList[index].id,
                                            eventsList[index].name,
                                            eventsList[index].date,
                                            eventsList[index].title,
                                              widget.namett,
                                            eventsList[index].desc,
                                            eventsList[index].clas,
                                            eventsList[index].room, eventsList[index].idUser
                                          )),
                                        ));
                                  },
                                  child: Container(
                                    width: 120,
                                    height:25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue,
                                    ),

                                    child: Center(child: Text("Không vi phạm",style: TextStyle(fontSize: 18,color: Colors.white),)),
                                  ),),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>Provider<Bloc>.value(
                                          value: Bloc(),
                                          child: PhanhoiAdmin2(
                                              eventsList[index].id,
                                              eventsList[index].name,
                                              eventsList[index].date,
                                              eventsList[index].title,
                                              widget.namett,
                                              eventsList[index].desc,
                                              eventsList[index].clas,
                                              eventsList[index].room, eventsList[index].idUser
                                          )),
                                    ));
                                  },
                                  child: Container(
                                    width: 100,
                                    height:25,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),

                                    child: Center(child: Text("Vi phạm",style: TextStyle(fontSize: 18,color: Colors.white),)),
                                  ),),
                              ],
                            )



                          ],
                        ),
                      )),
                  SizedBox(height:20 ,)

                ],
              ),


            );
          });
    }) ,
    );

  }
}
