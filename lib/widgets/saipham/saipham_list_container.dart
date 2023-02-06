import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/saipham_table.dart';
import 'package:cnpm/events/add_todo.dart';
import 'package:cnpm/model/saipham.dart';
import 'package:cnpm/widgets/login2/comHelper.dart';
import 'package:cnpm/widgets/saipham/phanhoi.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
class SaiphamContainer extends StatefulWidget {
  const SaiphamContainer({Key? key}) : super(key: key);

  @override
  _SaiphamContainerState createState() => _SaiphamContainerState();
}

class _SaiphamContainerState extends State<SaiphamContainer> {

  String disc = '';
  String username  = '';
  late  int id;
  late SaiphamTable dataBaseHelper;
  List<SaiPham> eventsList = [];
  loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt("id")!;
      username =prefs.getString("namedisplay")!;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.dataBaseHelper= SaiphamTable();
    loadCounter();
    this.dataBaseHelper.initializeDB().whenComplete(() async {
      dataBaseHelper.selectEventSaiPham(id).then((value) => {
        setState(() {
          eventsList = value;
        })
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      var bloc = Provider.of<Bloc>(context);
    return ListView.builder(
        itemCount: eventsList.length == 0 ? 0 : eventsList.length,
        key: UniqueKey(),
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
                              Text("Người nhận xét: "+eventsList[index].namett,style: TextStyle(fontSize: 20,),),
                              Text("Ghi chú: "+eventsList[index].desc,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Lớp: "+eventsList[index].clas,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                                  SizedBox(width:20 ,),
                                  Text("Phòng: "+eventsList[index].room,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                                ],
                              ),

                              if(eventsList[index].sp=="Vi Phạm")...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text('Vi Phạm',style: TextStyle(fontSize: 16,color: Colors.white),),
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: ()
                                      {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return Phanhoi(
                                              eventsList[index].id,
                                              eventsList[index].name,
                                              eventsList[index].date,
                                              eventsList[index].title,
                                              eventsList[index].namett,
                                              eventsList[index].desc,
                                              eventsList[index].clas,
                                              eventsList[index].room,

                                          );
                                        },));
                                      },
                                      child: Container(
                                        width: 200,
                                        height:25,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.red,
                                        ),

                                        child: Center(child: Text("Phản hồi sai phạm",style: TextStyle(fontSize: 18,color: Colors.white),)),
                                      ),),
                                  ],
                                )

                              ]

                              else if(eventsList[index].sp=="Không vi phạm")...[
                                    Container(
                                      key: UniqueKey(),
                                      margin: EdgeInsets.all(10),
                                      height: 30,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Center(
                                        child: Text('Không vi phạm',style: TextStyle(fontSize: 16,color: Colors.white),),
                                      ),
                                    ),
                              ]
                              else ...[
                                  Container(
                                    key: UniqueKey(),
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
                              ]

                            ],
                          ),
                        )),


                  SizedBox(height:20 ,)

                ],
              ),


          );
        });
    });
  }
}
