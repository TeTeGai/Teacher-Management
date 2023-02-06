

import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/model/details.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class detailslist extends StatefulWidget {

  final int idnews;
  detailslist(this.idnews);

  @override
  _detailslistState createState() => _detailslistState();
}

class _detailslistState extends State<detailslist> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var bloc = Provider.of<Bloc>(context);
    bloc.detailsData(widget.idnews);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<Bloc>(
          builder: (context,bloc,child) =>
              StreamBuilder<List<Details>>(
                  stream: bloc.detailslistStream,
                  builder: (context,snapshot) {
                    switch(snapshot.connectionState)
                    {
                      case ConnectionState.active:
                        return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return Container(
                                  child: Column(
                                    children: [
                                     
                                      Padding(
                                        padding: EdgeInsets.only(top: 20,left: 20,right: 20),
                                          child: Text(snapshot.data![index].title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                      Text(snapshot.data![index].time,style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic),),
                                      SizedBox(height: 20,),
                                      Text(snapshot.data![index].text1,style: TextStyle(fontSize: 20)),
                                      SizedBox(height: 20,),
                                      Image.network(snapshot.data![index].img1),
                                      SizedBox(height: 20,),
                                      Text(snapshot.data![index].text2, style: TextStyle(fontSize: 20)),
                                      SizedBox(height: 20,),
                                      Image.network(snapshot.data![index].img2),
                                      SizedBox(height: 20,),



                                    ],
                                  )



                              );
                            });

                      case ConnectionState.waiting:
                        return Center(
                          child: Container(
                            width: 70,
                            height: 70,
                            child: Text("Empty"),
                          ),
                        );

                      case ConnectionState.none:
                      default:
                        return Center(
                          child: Container(
                            width: 70,
                            height: 70,
                            child: CircularProgressIndicator(),
                          ),
                        );
                    }


                  }

              )),
    );
  }
}

