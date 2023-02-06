import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/saipham_table.dart';
import 'package:cnpm/events/add_todo.dart';
import 'package:cnpm/model/saipham.dart';
import 'package:cnpm/widgets/login2/comHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
class GhinhanSP extends StatefulWidget {
  int id;
  String name;
  String title;
  String room;
  String clas;
  String date;
  String namett;
  int idUser;
  GhinhanSP(this.id, this.name, this.title, this.room, this.clas, this.date,this.namett,this.idUser);

  @override
  _GhinhanSPState createState() => _GhinhanSPState();
}

class _GhinhanSPState extends State<GhinhanSP> {
  late  int idUser;
  late String namett;
  String disc = '';
  String _selectedtype = 'Không vi phạm';
  late String formattedDate;
  TextEditingController dateinput = TextEditingController();
  late SaiphamTable dataBaseHelper;
  List<SaiPham> eventsList = [];
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
    this.dataBaseHelper= SaiphamTable();
    this.dataBaseHelper.initializeDB().whenComplete(() async {
    });

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
                      Text("Hình thức",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 1.w),
                        child: DropdownButton(
                          value: _selectedtype,
                          isDense: true,
                          onChanged: (select) {
                            setState(() {
                              _selectedtype = '$select';
                            });
                          },
                          items: ['Không vi phạm', 'Vi Phạm'].map((values) {
                            return DropdownMenuItem(
                              child: new Text(values),
                              value: values,
                            );
                          }).toList(),
                        ),
                      ),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Lý do",style: TextStyle(fontSize: 18,color: Colors.grey),),
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
                              AddSaiphamEvent(
                                  widget.id,
                                  widget.name,
                                  widget.title,
                                  widget.room,
                                  widget.clas,
                                  widget.date,
                                  widget.idUser,
                                  disc,
                                  _selectedtype,
                                  widget.namett,
                                  widget.namett));
                          alertDialog1(context, "Ghi nhận sai phạm thành công");
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
