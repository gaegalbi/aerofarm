import 'package:flutter/material.dart';
class MainColor{
  static const ten = Color.fromRGBO(93, 195, 121, 100);
  static const thirty = Color.fromRGBO(186, 244, 111, 100);
  static const sixty = Color.fromRGBO(255, 255, 255, 100);
}
class LrTheme {
  static const button = TextStyle(
      color: Colors.black,
      decoration: TextDecoration.none,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w900,
      fontSize: 25);
  //LRPageTop(도시농부)
  static const title = TextStyle(
      color: Colors.black,
      decoration: TextDecoration.none,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w900,
      fontSize: 50);
}

class MainTheme {
  static const double drawerPadding = 5.0;
  static const drawerButton = TextStyle(
      color: Colors.black,
      decoration: TextDecoration.none,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w700,
      fontSize: 30);
  static const button = TextStyle(
      color: Colors.black,
      decoration: TextDecoration.none,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w900,
      fontSize: 25);
  //MainPage(도시농부)
  static const title = TextStyle(
      color: Colors.black,
      decoration: TextDecoration.none,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w900,
      fontSize: 50);
}
