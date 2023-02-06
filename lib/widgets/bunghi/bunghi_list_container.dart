import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/baobu_table.dart';
import 'package:cnpm/db/bunghi_table.dart';
import 'package:cnpm/model/baonghi.dart';
import 'package:cnpm/model/bunghi.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Bunghi_container extends StatefulWidget {
  const Bunghi_container({Key? key}) : super(key: key);

  @override
  _Bunghi_containerState createState() => _Bunghi_containerState();
}



class _Bunghi_containerState extends State<Bunghi_container> {
  late  int id;
  late BunghiTable dataBaseHelper;
  List<Bunghi> eventsList = [];
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
    this.dataBaseHelper= BunghiTable();

    loadCounter();
    this.dataBaseHelper.initializeDB().whenComplete(() async {
      dataBaseHelper.selectEventCalendar(id).then((value) => {
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

                            Text(eventsList[index].name,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Lớp: "+eventsList[index].clas,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                                SizedBox(width:20 ,),
                                Text("Phòng: "+eventsList[index].room,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                              ],
                            ),
                            Text("Lý do: "+eventsList[index].lydo,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                              Container(
                                margin: EdgeInsets.all(10),
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text('Báo nghỉ',style: TextStyle(fontSize: 16,color: Colors.white),),
                                ),
                              ),





                          ],
                        ),
                      )),
                ],
              )



          );
        });
  }
}
