import 'package:flutter/material.dart';
import 'package:get/get.dart';

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

class MainColor {
/*  static const ten = Color.fromRGBO(93, 195, 121, 100);
  static const thirty = Color.fromRGBO(186, 244, 111, 100);
  static const sixty = Color.fromRGBO(255, 255, 255, 100);*/
  static const six =
  Color.fromRGBO(18, 24, 36, 1);
  static const sixChange =
  Color.fromRGBO(42, 48, 60, 1);
      //Color.fromRGBO(30, 36, 55, 1); //Color.fromRGBO(18, 24, 36, 100);
  static const one =
  Color.fromRGBO(64, 78, 105, 1);
      //Color.fromRGBO(95, 114, 151, 1); //Color.fromRGBO(64, 78, 105, 100);
  static const three =  Color.fromRGBO(57, 87, 183, 1); //Color.fromRGBO(80, 130, 255, 1);
  static const filter =  Color.fromRGBO(107, 137, 233, 1);
// Color.fromRGBO(57, 87, 183, 100); //Color.fromRGBO(64, 91, 177, 100);
}

class MainSize {
  static final double widthRatio =Get.width/375;
  static final double heightRatio =  Get.height/812;
  static final double width =Get.width * widthRatio;
  static final double height =  Get.height * heightRatio;
  static final double toolbarHeight = height * 0.086;
}

class LoginRegisterScreenTheme {
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

class MainScreenTheme {
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
  static const subTitle = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 30);
  static const name = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 43);
  static const nameSub = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 30);
  static const modify = TextStyle(
      color: MainColor.one,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);
  static const drawerButton = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 29);
  static const profileField = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 30);
  static const profileEditField = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 28);
  static const profileInfo = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 28);
  static const profileAddress = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 24);
  static const profileMapButton = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 18);
}

class DeviceScreenTheme {
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
  static const led = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);

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

class CommunityScreenTheme {
  static const title = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 25);
  static const titleButtonTrue = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 18);
  static const titleButtonFalse= TextStyle(
      color: Colors.grey,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 18);
  static const announce = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 22);
  static const main = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 20);
  static const subCommentCount = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 17);
  static const subEtc = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 14);
  static const sub1 = TextStyle(
      color: Colors.red,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 14);

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
      fontSize: 17);
  static const commentDate = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 15);
  static const commentReply = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 15);
  static const commentDelete = TextStyle(
      color: Colors.red,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 15);
  static const commentModify = TextStyle(
      color: Colors.grey,//Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 15);
  static const replyButtonFont = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 17);
  static const replyButtonFalseFont = TextStyle(
      color: Colors.grey,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 17);
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
  static const boardDrawer = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);
  static const checkBoxFont = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 26);
  static const checkBoxDisable = TextStyle(
      color: Colors.grey,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 26);
  static const floatingButton = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 17);
  static const commentWriter = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);
  static const commentOwner = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 13);
  static const commentWriterOver = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 16);
  static const searchTextTrue = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);
  static const searchTextFalse = TextStyle(
      color: MainColor.one,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);
  static const searchButton = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);
  static const commentMenuButton = TextStyle(
      color: MainColor.three,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 30);
  static const commentMenuDeleteButton = TextStyle(
      color: Colors.red,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 30);
  static const tabBarText = TextStyle(
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);
  static const activityNickname = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 30);
  static const activityButton = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 19);
  static const activityCommentContent = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 20);
  static const activityCommentDate = TextStyle(
      color: Colors.grey,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 16);
  static const activityCommentTitle = TextStyle(
      color: Colors.grey,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 20);
  static const filter = TextStyle(
      color: MainColor.filter,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 20);
  static const postTagFont = TextStyle(
      color: MainColor.filter,
      decoration: TextDecoration.none,
      fontFamily: 'bmAir',
      fontSize: 17);
  static const searchInfo = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 18);
  static const deleteTnFTrue = TextStyle(
      color: Colors.white,
      decoration: TextDecoration.none,
      fontFamily: 'bmPro',
      fontSize: 18);
}
