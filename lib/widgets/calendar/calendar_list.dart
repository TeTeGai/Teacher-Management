import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/bunghi_table.dart';
import 'package:cnpm/db/calendar_table.dart';
import 'package:cnpm/db/db.dart';
import 'package:cnpm/events/add_todo.dart';
import 'package:cnpm/model/bunghi.dart';
import 'package:cnpm/model/calendar.dart';
import 'package:cnpm/model/login.dart';
import 'package:cnpm/widgets/calendar/baobu.dart';
import 'package:cnpm/widgets/login2/comHelper.dart';
import 'package:cnpm/widgets/login2/login_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

import 'nghibu.dart';
class Calendarlist extends StatefulWidget {
  const Calendarlist({Key? key}) : super(key: key);

  @override
  _todolistState createState() => _todolistState();
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class _todolistState extends State<Calendarlist> {

  late CalendarTable dataBaseHelper;
  List<Calendar> eventsList = [];
  List<Calendar> alleventsList = [];
  String value = "a",
      date = '',
      _selectedtype = 'Không vi phạm',
      repeat = "",
      disc = '',
      tiet='',
      datebu='',
      enddate = '';
  late int id;
  List<String> type = ['Không vi phạm', 'Vi Phạm'];

LoginForm lg = new LoginForm();
  void calendarTapped(CalendarTapDetails details) {

    if (details.targetElement == CalendarElement.header) {
    } else if (details.targetElement == CalendarElement.viewHeader) {
    } else if (details.targetElement == CalendarElement.calendarCell) {
      date = new DateFormat('yyyy-MM-dd').format(details.date!).toString();
      enddate = new DateFormat('yyyy-MM-dd').format(details.date!).toString();
      dataBaseHelper.retrieveEvents(date,id).then((value) => {
        setState(() {
          eventsList = value;

        })
      });

      dataBaseHelper.selectEventCalendar1(id).then((value) => {
        setState(() {
          alleventsList = value;
        })
      });
    }
  }
  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];

        for (int j = 0; j < alleventsList.length; j++) {
          DateTime dateTime = DateTime.parse(alleventsList[j].date);
          appointments.add(Appointment(
            recurrenceExceptionDates: <DateTime>[dateTime] ,
            startTime: dateTime,
            endTime: DateTime(2022,01,28).add(Duration(hours: 0)),
            color: Colors.red,
            startTimeZone: '',
            endTimeZone: '',
          ));


        }


    return _AppointmentDataSource(appointments);
  }


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
    this.dataBaseHelper= CalendarTable();
    loadCounter();
    this.dataBaseHelper.initializeDB().whenComplete(() async {
      dataBaseHelper.selectEventCalendar1(id).then((value) => {
        setState(() {
          eventsList = value;

        })
      });
    });

  }

  DateTime now1  = DateTime.now();
  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      var bloc = Provider.of<Bloc>(context);
      return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(children: [
              Container(
                  height: 45.h,
                  width: 95.w,
                  child: SfCalendar(
                    view: CalendarView.month,
                    onTap: calendarTapped,
                     dataSource: _getCalendarDataSource(),

                  )),

                Container(
                    height: 53.h,
                    child: ListView.builder(
                        itemCount: eventsList.length == 0 ? 0 : eventsList.length ,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 1.h, horizontal: 2.h),
                              child: Container(
                                  height: 14.h,
                                  margin: EdgeInsets.symmetric(vertical: 1.h),
                                  child: Row(children: [


                                        Container(
                                          margin: EdgeInsets.symmetric(horizontal: 2.w),
                                          child: Text(
                                            "Tiết "+eventsList[index].title,
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),

                                        Expanded(
                                          child: Column(
                                            children:[
                                              Container(
                                                child: Text("Ngày: "+eventsList[index].date,
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.bold)),
                                              ),
                                              Container(
                                                child: Text(eventsList[index].name,
                                                style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold)),
                                             ),
                                              Container(
                                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                                child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Row(
                                                      children:[
                                                        Icon(Icons.location_on,color: Colors.grey,),
                                                        Text("Phòng: "+eventsList[index].room,
                                                                style: TextStyle(
                                                                fontSize: 11.sp,
                                                                fontWeight: FontWeight.bold)),
                                                      ]
                                                    )
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(horizontal: 2.w),
                                                child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Row(
                                                        children:[
                                                          Icon(Icons.class_,color: Colors.grey,),
                                                          Text("Lớp: "+eventsList[index].clas,
                                                              style: TextStyle(
                                                                  fontSize: 11.sp,
                                                                  fontWeight: FontWeight.bold)),
                                                        ]
                                                    )
                                                ),
                                              ),
                                          ]
                                          ),
                                        ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context)=>Provider<Bloc>.value(
                                                    value: Bloc(),
                                                    child:Nghibu(
                                                      eventsList[index].id,
                                                      eventsList[index].title,
                                                      eventsList[index].date,
                                                      eventsList[index].name,
                                                      eventsList[index].room,
                                                      eventsList[index].clas,
                                                    )
                                                  )));

                                            },
                                            child: Container(
                                              width: 80,
                                              height:25,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.red,
                                              ),

                                              child: Center(child: Text("Báo nghỉ",style: TextStyle(fontSize: 18,color: Colors.white),)),
                                            ),),


                                          //-----------------------------------------------------------------------------------------
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context)=>Provider<Bloc>.value(
                                                    value: Bloc(),
                                                    child: Baobu(
                                                      eventsList[index].id,
                                                      eventsList[index].title,
                                                      eventsList[index].date,
                                                      eventsList[index].name,
                                                      eventsList[index].room,
                                                      eventsList[index].clas,
                                                    ),
                                                  )));
                                            },
                                            child: Container(
                                              width: 80,
                                              height:25,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.blue,
                                              ),
                                              child: Center(child: Text("Báo bù",style: TextStyle(fontSize: 18,color: Colors.white),)),
                                            ),),
                                        ],
                                      ),
                                    )


                                    //     height: 40,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius: BorderRadius.circular(20),
                                    //       color: Colors.red,
                                    //     ),
                                    //
                                    //     child: Text("Danh gia tiet hoc"),
                                    //   ),),
                                  ])));
                        })),
            ]),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //
            //   },
            //   child: Icon(Icons.add),
            // ),
          );
    });
  }
}


