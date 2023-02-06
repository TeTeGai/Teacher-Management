import 'package:cnpm/bloc/bloc.dart';
import 'package:cnpm/widgets/news/news_container.dart';
import 'package:cnpm/widgets/seeall/seeall_container.dart';
import 'package:cnpm/widgets/seeall/seeall_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SeeallPage extends StatefulWidget {
  const SeeallPage({Key? key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<SeeallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Thông tin")),
      ),
      body: Column(
        children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Seeall()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
    );
  }
}
