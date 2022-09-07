import 'dart:convert';

import 'package:capstone/themeData.dart';
import 'package:capstone/widget/CustomAppBar.dart';
import 'package:capstone/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: MainColor.six,
        appBar: CustomAppBar(title: "", iconData: Icons.chevron_left, onPressed:(){ Get.back();},home: false,),
        body: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                children: [
                  const Text(
                    "도시농부",
                    style: LoginRegisterScreenTheme.title,
                  ),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              bottom: MainSize.height * 0.018,
                              top: MainSize.height * 0.036),
                          child: const Text(
                            "도시농부에 가입했던 이메일을 입력해주세요.",
                            style: LoginRegisterScreenTheme.content,
                          )),
                      const Text(
                        "비밀번호 재설정 메일을 보내드립니다.",
                        style: LoginRegisterScreenTheme.content,
                      ),
                    ],
                  ),
                  CustomTextField(
                      controller: _emailController, hintText: "EMAIL을 입력해주세요"),
                  Container(
                    margin: EdgeInsets.only(
                        top: MainSize.height * 0.018,
                        bottom: MainSize.height* 0.08),
                    color: MainColor.three,
                    child: TextButton(
                      onPressed: () async {
                        //이메일 전송
                        var data = json.encode({"email": _emailController.text});
                        await http.post(
                            Uri.http(serverIP, '/login/reset-password'),
                            headers: {
                              "Content-Type": "application/json",
                            },
                            body: data);
                        Get.back();
                      },
                      child: const Text(
                        "전송",
                        style: LoginRegisterScreenTheme.button,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}