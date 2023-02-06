import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/model/news.dart';
import 'package:cnpm/widgets/details/details_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Seeall extends StatefulWidget {
  const Seeall({Key? key}) : super(key: key);

  @override
  _SeeallState createState() => _SeeallState();
}

class _SeeallState extends State<Seeall> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var bloc = Provider.of<Bloc>(context);
    bloc.initData();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Bloc>(
        builder: (context,bloc,child) =>
            StreamBuilder<List<News>>(
                stream: bloc.newslistStream,
                builder: (context,snapshot) {
                  switch(snapshot.connectionState)
                  {
                    case ConnectionState.active:
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                    onTap: ()
                                    {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=>Provider<Bloc>.value(
                                            value: Bloc(),
                                            child: detailslist(snapshot.data![index].id),
                                          )));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 20),
                                      height: 130,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                          color: Colors.grey.withOpacity(0.5)),
                                      child: Row(
                                        children: [
                                          Container(
                                            child: Stack(
                                              children: [
                                                ClipRRect(

                                                  child: Container(
                                                    height: 120,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage('asset/img/iconBgNew.png'),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Positioned(
                                                  top: 10,
                                                  left: 20,  child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(snapshot.data![index].img), fit: BoxFit.cover)),
                                                ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.all(7),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text(snapshot.data![index].time),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(snapshot.data![index].title,style: TextStyle(fontSize: 18,),
                                                    overflow: TextOverflow.fade,
                                                    maxLines: 4,
                                                    softWrap: true,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],

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

            ));
  }
}

