import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../main.dart';

register(
    TextEditingController emailController,
    TextEditingController nameController,
    TextEditingController nicknameController,
    TextEditingController passwordController,
    TextEditingController passwordConfirmController,
    BuildContext context) async {
  //회원 가입
  if (passwordController.text != passwordConfirmController.text) {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(milliseconds: 900), () {
            Navigator.pop(context);
          });
          return const AlertDialog(
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.all(5),
            content: Text(
              "비밀번호가\n같지 않습니다.",
              style: TextStyle(fontSize: 26),
              textAlign: TextAlign.center,
            ),
          );
        });
  } else {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordConfirmController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        nicknameController.text.isNotEmpty) {}
    var data = json.encode({
      "email": emailController.text,
      "password": passwordController.text,
      "confirmPassword": passwordConfirmController.text,
      "name": nameController.text,
      "nickname": nicknameController.text
    });
    final response = await http.post(Uri.http(serverIP, '/signup/api'),
        headers: {
          "Content-Type": "application/json",
        },
        body: data);
    if (response.statusCode == 400) {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 900), () {
              Navigator.pop(context);
            });
            String message;
            if (jsonDecode(response.body)['validation'].length >= 2) {
              message = "빈 칸을 채워주세요.";
            } else {
              String tmp =
                  jsonDecode(utf8.decode(response.bodyBytes))['validation']
                      .toString();
              message = tmp.substring(tmp.indexOf(":") + 1, tmp.length - 1);
            }
            return AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: const EdgeInsets.all(5),
              content: Text(
                message,
                style: const TextStyle(fontSize: 26),
                textAlign: TextAlign.center,
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            Future.delayed(const Duration(milliseconds: 900), () {
              Navigator.pop(context);
              Get.back();
            });
            return const AlertDialog(
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.all(5),
              content: Text(
                "해당 이메일로\n인증링크를 보냈습니다.",
                style: TextStyle(fontSize: 28),
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }
}
