import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/db/news_table.dart';
import 'package:cnpm/model/news.dart';
import 'package:cnpm/widgets/details/details_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewsContainer extends StatefulWidget {
  const NewsContainer({Key? key}) : super(key: key);

  @override
  _NewsContainerState createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  late NewsTable dataBaseHelper;
  List<News> eventsList = [];
    @override
    void didChangeDependencies() {
      // TODO: implement didChangeDependencies
      super.didChangeDependencies();
    }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.dataBaseHelper= NewsTable();

    this.dataBaseHelper.initializeDB().whenComplete(() async {
      dataBaseHelper.selectAllNews().then((value) => {
        setState(() {
          eventsList = value;
        })
      });
    });
  }
    @override
    Widget build(BuildContext context) {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: eventsList.length == 0 ? 0 : eventsList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  GestureDetector(
                                      onTap: ()
                                      {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=>Provider<Bloc>.value(
                                              value: Bloc(),
                                              child: detailslist(eventsList[index].id),
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
                                                        // image: DecorationImage(
                                                        //   image: AssetImage('asset/img/iconBgNew.png'),
                                                        //   fit: BoxFit.contain,
                                                        // ),
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
                                                              image: NetworkImage(eventsList[index].img), fit: BoxFit.cover)),
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
                                                        Text(eventsList[index].time),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(eventsList[index].title,style: TextStyle(fontSize: 18,),
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



                    }


                  }



