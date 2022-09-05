import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themeData.dart';

class MainScreenBox extends StatelessWidget {
  final String text;
  final VoidCallback? route;
  const MainScreenBox({Key? key, required this.text, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: MainColor.three,
            borderRadius: BorderRadius.circular(30)
        ),
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(left: 15,right: 5,top: 20,bottom: 20),
        child: TextButton(
          onPressed: route,
          child: Text(
            text,
            style: MainScreenTheme.button,
          ),
        ),
      ),
    );
  }
}