import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/baobu_table.dart';
import 'package:cnpm/events/add_todo.dart';
import 'package:cnpm/widgets/login2/comHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
class Baobu extends StatefulWidget {
  int id;
  String title;
  String date;
  String name;
  String room;
  String clas;


  Baobu(this.id, this.title, this.date, this.name, this.room, this.clas);

  @override
  _BaobuState createState() => _BaobuState();
}

class _BaobuState extends State<Baobu> {
  late  int idUser;
  String disc = '';
  List<String> type = ['1-3', '3-5','5-7','7-9','1-5','3-7','7-9'];
  String _selectedtype = '1-3';
  late String formattedDate;
  TextEditingController dateinput = TextEditingController();
  late BaoBuTable dataBaseHelper;
  List<Baobu> eventsList = [];
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
    this.dataBaseHelper= BaoBuTable();
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
                      Text("Chọn tiết",style: TextStyle(fontSize: 18,color: Colors.grey),),
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
                          items: ['1-3', '3-5','5-7','7-9','1-5','5-9'].map((values) {
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
              Container(
                  padding: EdgeInsets.all(15),
                  height:100,
                  child:Center(
                      child:TextField(
                        controller: dateinput, //editing controller of this TextField
                        decoration: InputDecoration(
                            icon: Icon(Icons.calendar_today), //icon of text field
                            labelText: "Chọn ngày bù" //label text of field
                        ),
                        readOnly: true,  //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context, initialDate: DateTime.now(),
                              firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          );

                          if(pickedDate != null ){
                            print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                            formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate); //formatted date output using intl package =>  2021-03-16
                            //you can implement different kind of Date Format here according to your requirement

                            setState(() {
                              dateinput.text = formattedDate; //set output date to TextField value.
                            });
                          }else{
                            print("Date is not selected");
                          }
                        },
                      )
                  )
              ),


              Container(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        if(dateinput.text == "")
                          {
                            alertDialog(context, "Vui lòng chọn ngày để bù");
                          }
                        else
                          {
                            bloc.event.add(
                                AddBaobusEvent(
                                    widget.id,
                                    widget.name,
                                    widget.title,
                                    widget.room,
                                    widget.clas,
                                    widget.date,
                                    idUser,
                                    0,
                                    _selectedtype,
                                    formattedDate));
                            alertDialog1(context, "Báo bù thành công");
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
