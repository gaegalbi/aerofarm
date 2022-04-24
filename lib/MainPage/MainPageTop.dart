import 'package:capstone/themeData.dart';
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
    return Column(
      children: [
        const Text(
          "도시농부",
          style: MainTheme.title,
        ),
        Container(
          //margin: EdgeInsets.only(top: margin),
          color: Colors.grey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.55,
        )
      ],
    );
  }
}
