import 'package:flutter/material.dart';

class MainPageTop extends StatefulWidget {
  const MainPageTop({Key? key}) : super(key: key);

  @override
  State<MainPageTop> createState() => _MainPageTopState();
}

class _MainPageTopState extends State<MainPageTop> {
  double margin = 20;
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: margin),
      child: Column(
        children: [
          Text(
            "도시농부",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Container(
            //margin: EdgeInsets.only(top: margin),
            color: Colors.grey,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.55,
          )
        ],
      ),
    );
  }
}
