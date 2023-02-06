import 'package:carousel_slider/carousel_slider.dart';
import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/widgets/news/news_container.dart';
import 'package:cnpm/widgets/seeall/seeall_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<String> imageList = [
    "https://doancnpm222.000webhostapp.com/banner1.jpg",
    "https://doancnpm222.000webhostapp.com/banner2.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        resizeToAvoidBottomInset: false,
      body: Column(
        children: [
             Container(
               width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      
                      "Trường ĐH tài nguyên & môi trường",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                      ),
                      items: imageList.map((e) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: <Widget>[
                            Image.network(e,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height *0.3,
                              fit: BoxFit.cover,)
                          ],
                        ) ,

                      )).toList(),
                    ),

                ],
              ),
            ),

          Expanded(
              child: Container(
                padding: EdgeInsets.all(30),
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Bài báo"),
                        FlatButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>Provider<Bloc>.value(
                                    value: Bloc(),
                                    // child: _chil[_currentIndex]
                                    child: SeeallPage(),

                                  )));
                            },
                            child: Text(
                              "Xem tất cả",
                            )),
                      ],
                    ),

                       Expanded(
                         child: SingleChildScrollView(
                            child: Column(
                              children: [
                                NewsContainer()
                              ],
                            ),
                          ),
                       )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
