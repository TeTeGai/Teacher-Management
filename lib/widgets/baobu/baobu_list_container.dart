import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/baobu_table.dart';
import 'package:cnpm/db/bunghi_table.dart';
import 'package:cnpm/model/baonghi.dart';
import 'package:cnpm/model/bunghi.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Baobu_container extends StatefulWidget {
  const Baobu_container({Key? key}) : super(key: key);

  @override
  _Bunghi_containerState createState() => _Bunghi_containerState();
}



class _Bunghi_containerState extends State<Baobu_container> {
  late  int id;
  late BaoBuTable dataBaseHelper1;
  List<Baobu> eventsList1 = [];
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

    this.dataBaseHelper1= BaoBuTable();
    loadCounter();
    this.dataBaseHelper1.initializeDB().whenComplete(() async {
      dataBaseHelper1.selectBaobu(id).then((value) => {
        setState(() {
          eventsList1 = value;

        })
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: eventsList1.length == 0 ? 0 : eventsList1.length,
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
                          Text("Thời gian: "+eventsList1[index].date,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          Text("Tiết: "+eventsList1[index].title,style: TextStyle(fontSize: 20,),),
                        ],
                      ),

                      Text(eventsList1[index].name,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Lớp: "+eventsList1[index].clas,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                          SizedBox(width:20 ,),
                          Text("Phòng: "+eventsList1[index].room,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Tiết bù: "+eventsList1[index].titlebu,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                          SizedBox(width:20 ,),
                          Text("Ngày bù: "+eventsList1[index].datebu,style: TextStyle(fontSize: 17,fontStyle: FontStyle.italic),),
                        ],
                      ),

                      if(eventsList1[index].cate==1)...[
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

                      ]

                      else ...[
                        Container(
                          margin: EdgeInsets.all(10),
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text('Báo bù trước',style: TextStyle(fontSize: 16,color: Colors.white),),
                          ),
                        ),
                      ],

                    ],
                  ),
                )),
          ],
        )



    );
    });
  }
}
