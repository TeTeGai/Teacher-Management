import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/saipham_table.dart';
import 'package:cnpm/events/add_todo.dart';
import 'package:cnpm/model/saipham.dart';
import 'package:cnpm/widgets/login2/comHelper.dart';
import 'package:cnpm/widgets/saipham/home.dart';
import 'package:cnpm/widgets/thanhtra/phanhoi_list_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
class PhanhoiAdmin2 extends StatefulWidget {

  int id;
  String name;
  String date;
  String title;
  String namett;
  String desc;
  String clas;
  String room;
  int idUser;

  PhanhoiAdmin2(this.id,this.name,this.date, this.title, this.namett, this.desc, this.clas, this.room,this.idUser);

  @override
  _PhanhoiState createState() => _PhanhoiState();
}


class _PhanhoiState extends State<PhanhoiAdmin2> {

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
    var bloc = Provider.of<Bloc>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Center(child: Text("Phản hồi vi phạm")),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          decoration:  BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ngày",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Text(widget.date,style: TextStyle(fontSize: 20)),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Người nhận xét",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Text(widget.namett,style: TextStyle(fontSize: 20)),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Môn học",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Text(widget.name,style: TextStyle(fontSize: 20)),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tiết",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Text(widget.title,style: TextStyle(fontSize: 20)),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Phòng",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Text(widget.room,style: TextStyle(fontSize: 20)),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lớp",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Text(widget.clas,style: TextStyle(fontSize: 20)),
                    ]
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text("Lời nhận xét",style: TextStyle(fontSize: 18,color: Colors.grey),),
                    SizedBox(height: 10,),
                    Text(widget.desc,style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Ghi chú",style: TextStyle(fontSize: 18,color: Colors.grey),),
                    ]
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 1.w, horizontal: 2.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onChanged: (value) {
                        setState(() {
                          disc = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.lightBlue),
                        ),
                        hintStyle: TextStyle(color: Colors.black),
                        fillColor: Colors.lightBlue,
                      ),
                    ),
                  )),
              Container(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        if(disc.trim().isEmpty)
                        {
                          alertDialog(context, "Vui lòng nhập lý do");
                        }
                        else
                        {
                          bloc.event.add(AddSaiphamEvent(
                              widget.id,
                              widget.name,
                              widget.title,
                              widget.room,
                              widget.clas,
                              widget.date,
                              widget.idUser,
                              disc,
                              "Vi Phạm",
                              widget.namett,
                              widget.namett));
                          alertDialog1(context, "Phản hồi thành công");
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                              builder: (context)=>Provider<Bloc>.value(
                                value: Bloc(),
                                child: PhanhoiContainer(username),
                              )),(Route<dynamic> route) => false);
                        }
                      });

                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context)=>Provider<Bloc>.value(
                            value: Bloc(),
                            child: PhanhoiContainer(username),
                          )),(Route<dynamic> route) => false);
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Colors.blue,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    child: Text(
                      "Xác nhận",
                      style: TextStyle(color: Colors.white,fontSize: 20),
                    ),
                  ))

            ],
          ),
        ),

      ),
    );
  }
}
