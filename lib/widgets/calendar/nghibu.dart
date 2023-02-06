import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/bunghi_table.dart';
import 'package:cnpm/events/add_todo.dart';
import 'package:cnpm/widgets/login2/comHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
class Nghibu extends StatefulWidget {
  int id;
  String title;
  String date;
  String name;
  String room;
  String clas;


  Nghibu(this.id, this.title, this.date, this.name, this.room, this.clas);

  @override
  _NghibuState createState() => _NghibuState();
}

class _NghibuState extends State<Nghibu> {
  String disc = '';
  late  int idUser;
  late BunghiTable dataBaseHelper;
  List<Nghibu> eventsList = [];
  loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idUser = prefs.getInt("id")!;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCounter();
    this.dataBaseHelper= BunghiTable();
    this.dataBaseHelper.initializeDB().whenComplete(() async {
    });

  }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed:  () {},
    );

    // set up the AlertDialog

  }
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<Bloc>(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: Center(child: Text("Báo nghỉ")),
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

                          bloc.event.add(
                              AddBunghisEvent(
                                  widget.id,
                                  widget.name,
                                  widget.title,
                                  widget.room,
                                  widget.clas,
                                  widget.date,
                                  idUser,
                                   disc,
                              ));
                          alertDialog1(context, "Báo nghỉ thành công");
                          Navigator.pop(context);
                        }
                      });

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
