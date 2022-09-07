import 'dart:convert';
import 'package:capstone/provider/Controller.dart';
import 'package:capstone/service/getProfile.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../main.dart';

editProfile(
  BuildContext context,
  TextEditingController nicknameController,
  TextEditingController nameController,
  TextEditingController phoneNumberController,
  TextEditingController address1Controller,
  TextEditingController address2Controller,
  TextEditingController extraAddressController,
  TextEditingController zipCodeController,
) async {
  final userController = Get.put(UserController());

  if (nicknameController.text.isEmpty) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 800), () {
            Navigator.pop(context);
          });
          return const AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(5),
            content: Text(
              "닉네임을 적어주세요.",
              style: TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
          );
        });
  } else {
    var data = {
      "nickname": nicknameController.text,
      "name": nameController.text,
      "phoneNumber": phoneNumberController.text,
      "address1": address1Controller.text,
      "address2": address2Controller.text,
      "zipcode": zipCodeController.text,
      "extraAddress": extraAddressController.text.isNotEmpty
          ? extraAddressController.text
              .substring(1, extraAddressController.text.length - 1)
          : extraAddressController.text
    };
    var body = jsonEncode(data);

    final response = await http.post(Uri.http(serverIP,
        '/my-page/edit'),
        headers: {
          "Content-Type": "application/json",
          "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
        },
        body: body);

    Map<String, dynamic> status;
    if (jsonDecode(utf8.decode(response.bodyBytes))['validation'] != null) {
      status = jsonDecode(utf8.decode(response.bodyBytes))['validation'];
      switch (status.keys.first) {
        case "nickname":
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                Future.delayed(const Duration(milliseconds: 1500), () {
                  Navigator.pop(context);
                });
                return const AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.all(5),
                  content: Text(
                    "닉네임이 중복되거나\n올바르지 않습니다.",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                );
              });
          break;
        case "phoneNumber":
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                Future.delayed(const Duration(milliseconds: 1500), () {
                  Navigator.pop(context);
                });
                return const AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.all(5),
                  content: Text(
                    "연락처가 중복되거나\n올바르지 않습니다.",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                );
              });
          break;
        case "name":
          //이름 다섯글자
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                Future.delayed(const Duration(milliseconds: 1500), () {
                  Navigator.pop(context);
                });
                return const AlertDialog(
                  backgroundColor: Colors.transparent,
                  contentPadding: EdgeInsets.all(5),
                  content: Text(
                    "이름이 중복되거나\n올바르지 않습니다.",
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                );
              });
          break;
        default:
          print(status.keys.first);
          break;
      }
    }
    getProfile(userController.user.value.session, userController.user.value.session);
    Get.back();
  }
}
