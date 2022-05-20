import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainColor {
/*  static const ten = Color.fromRGBO(93, 195, 121, 100);
  static const thirty = Color.fromRGBO(186, 244, 111, 100);
  static const sixty = Color.fromRGBO(255, 255, 255, 100);*/
  static const six =
      Color.fromRGBO(30, 36, 55, 100); //Color.fromRGBO(18, 24, 36, 100);
  static const one =
      Color.fromRGBO(95, 114, 151, 100); //Color.fromRGBO(64, 78, 105, 100);
  static const three = Color.fromRGBO(80, 130, 255,
      100); //Color.fromRGBO(57, 87, 183, 100); //Color.fromRGBO(64, 91, 177, 100);
}

class MainSize {
  static double toobarHeight = Get.height * 0.1;
}

class LoginRegisterPageTheme {
  static const button = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 25);

  //tabbar unfocus시 스타일
  static const button1 = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 25);
  static const hint = TextStyle(
    color: Colors.grey,
    decoration: TextDecoration.none,
    fontFamily: 'bmAir',
    fontSize: 19,
  );
  static const text = TextStyle(
    color: Colors.white,
    decoration: TextDecoration.none,
    fontFamily: 'bmAir',
    fontSize: 19,
  );

  //비밀번호 재설정
  static const sButton = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 18);

  //비밀번호 재설정
  static const notMember = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 18);

  //LRPageTop(도시농부)
  static const title = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 55);
  static const content = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);
  static const registerTitle = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 18);
}

class MainTheme {
  //APPBAR , IPHONE 13 mini
  // leadingWidth 79, MediaQuery.of(context).size.width * 0.2106,
  // leading margin:EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
  //왼쪽 마진 18.75 , 0.2106

  //13 PRO MAX
  //leadingWidth 106 , 0.2231
  // 왼쪽 마진 21.375 , 0.045
  static const button = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);

  //MainPage(도시농부)
  static const title = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 55);
  static const name = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 45);
  static const modify = TextStyle(
      color: MainColor.one,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);
  static const drawerButton = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 30);
}

class MachinePageTheme {
  static const mName = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 30);
  static const mType = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 15);
  static const infoStatus = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 40);
  static const infoText = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);
  static const profileText = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 55);
}

class ProfilePageTheme {
  static const name = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 40);
  static const info = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 25);
  static const button = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 25);
}

class CommunityPageTheme {
  static const title = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 25);
  static const main = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 20);
  static const sub = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 13);
  static const sub1 = TextStyle(
      color: Colors.red,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 13);
  static const free = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPRO',
      fontSize: 16);
  static const all = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPRO',
      fontSize: 18);
  static const bottomAppBarList = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPRO',
      fontSize: 20);
  static const bottomAppBarFavorite = TextStyle(
      color: Colors.red,
      decoration: TextDecoration.none,
      fontFamily: 'bmPRO',
      fontSize: 20);
  static const bottomAppBarReply = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPRO',
      fontSize: 20);
  static const postTitle = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 28);
  static const postButton = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 18);
  static const postFont = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 18);
  static const postFalseFont = TextStyle(
      color: Colors.grey,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 18);
  static const contentInfo = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 13);
  static const chatTitle = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 22);
  static const chatContent = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 22);
  static const timeDefault = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 13);
}
