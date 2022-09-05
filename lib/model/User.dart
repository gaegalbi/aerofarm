import 'package:flutter/material.dart';

class User {
  String email ="";

  String name = "";

  String nickname = "";

  String phoneNumber = "";

  String address1 = ""; //대구시 북구 태전로31
  String address2 = ""; //311호
  String extraAddress = ""; //태전동

  String zipcode = "";
  String session = "";
  String rememberMe = "";
  Image? picture = const Image(
    image: AssetImage("assets/images/profile.png"),
  );
  //AssetImage? picture = const AssetImage("assets/images/profile.png");
}
