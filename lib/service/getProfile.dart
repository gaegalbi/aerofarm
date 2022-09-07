import 'dart:convert';
import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../main.dart';
import '../model/User.dart';

void getProfile(String session, String rememberMe) async {
  User user = User();
  final userController = Get.put(UserController());

  user.session = session;
  user.rememberMe = rememberMe;

  final response = await http.get(Uri.http(serverIP,
      '/api/my-page/info'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Cookie":"remember-me=$rememberMe;JSESSIONID=$session",
      }
  );
  Map<String, dynamic> _user = jsonDecode(utf8.decode(response.bodyBytes));

  user.email = _user['email'];

  user.picture = Image.network("http://$serverIP${_user['picture']}");
  user.nickname = _user['nickname'];
  if(_user['name']!=null && _user['name']!=""){
    user.name = _user['name'];
  }else{
    user.name = "미등록";
  }
  if(_user['phoneNumber'] !=null && _user['phoneNumber']!=""){
    user.phoneNumber = _user['phoneNumber'];
  }else{
    user.phoneNumber = "미등록";
  }

  if(_user['addressInfo']!=null){
    if(_user['addressInfo']['zipcode']!=""){
      user.zipcode = _user['addressInfo']['zipcode'];
    }
    if(_user['addressInfo']['address1']!=""){
      user.address1= _user['addressInfo']['address1'];
    }
    if(_user['addressInfo']['address2']!=""){
      user.address2 = _user['addressInfo']['address2'];
    }
    if(_user['addressInfo']['extraAddress']!=""){
      user.extraAddress = _user['addressInfo']['extraAddress'];
    }
  }
  userController.setUser(user);
}