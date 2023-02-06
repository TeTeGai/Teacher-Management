import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/saipham_table.dart';
import 'package:cnpm/model/saipham.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SaiphamPageAdmin extends StatefulWidget {
  int id;


  SaiphamPageAdmin(this.id);

  @override
  _SaiphamContainerState createState() => _SaiphamContainerState();
}

class _SaiphamContainerState extends State<SaiphamPageAdmin> {



  late SaiphamTable dataBaseHelper;
  List<SaiPham> eventsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.dataBaseHelper= SaiphamTable();

    this.dataBaseHelper.initializeDB().whenComplete(() async {
      dataBaseHelper.selectEventSaiPham(widget.id).then((value) => {
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

                            ]

                            else ...[
                              Container(
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
                            ],

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
        });
  }
}
