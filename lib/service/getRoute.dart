/*
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../LoginPage/LoginPageLogin.dart';
import '../MainPage/MainPageMyProfile.dart';
import '../MainPage/MainPageMyProfileEdit.dart';
import '../main.dart';
import '../provider/Controller.dart';

void getRoute(String before) async {
  switch(before){
    case "MainPageMyProfile":
      Get.to(()=>MainPageMyProfileEdit(user:_user));
      break;
    case "MainPageMyProfileEdit":
      Get.back();
      //Get.offAll(()=>CommunityPageForm(category: "ALL"));
      //Get.off(()=>MainPageMyProfile(user:_user, before: "MainPage",));
      break;
    case "CommunityPage":
      Get.to(()=>MainPageMyProfile(user:_user, before: "CommunityPage",));
      break;
    case "CommunityPageEdit":
      Get.to(()=>MainPageMyProfileEdit(user:_user,));
      break;
    default:
      Get.to(()=>MainPageMyProfile(user:_user, before: "MainPage",));
      break;
  }
  */
/*before=="MainPageMyProfile" ? Get.to(()=>MainPageMyProfileEdit(user:_user)) : Get.to(()=> MainPageMyProfile(user:_user));*//*

}*/
