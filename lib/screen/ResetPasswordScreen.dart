import 'dart:convert';

import 'package:capstone/themeData.dart';
import 'package:capstone/widget/CustomAppBar.dart';
import 'package:capstone/widget/CustomIconTextField.dart';
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

/*

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ScrollController _scrollController;
  late TextEditingController _emailController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MainColor.six,
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width * 0.2106,
          leading: Container(
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: FittedBox(
                child: IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  color: MainColor.three,
                  iconSize: 50,
                  // 패딩 설정
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.chevron_left,
                  ),
                  onPressed: () {
                    // Get.offAll(const LoginPage(reLogin: false,));
                    Get.back();
                  },
                ),
              )),
        ),
        body: Container(
          color: MainColor.six,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.036),
                    child: const Text(
                      "도시농부",
                      style: LoginRegisterPageTheme.title,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              bottom:
                              MediaQuery.of(context).size.height * 0.018),
                          child: const Text(
                            "도시농부에 가입했던 이메일을 입력해주세요.",
                            style: LoginRegisterPageTheme.content,
                          )),
                      const Text(
                        "비밀번호 재설정 메일을 보내드립니다.",
                        style: LoginRegisterPageTheme.content,
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.036),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      style: LoginRegisterPageTheme.text,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: MainColor.one,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "EMAIL을 입력해주세요",
                          hintStyle: LoginRegisterPageTheme.hint),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.018,
                        bottom: MediaQuery.of(context).size.height * 0.08),
                    color: MainColor.three,
                    child: TextButton(
                      onPressed: () async {
                        //이메일 전송
                        var data = json.encode({"email":_emailController.text});
                        await http.post(Uri.http(serverIP, '/login/reset-password'),
                            headers: {
                              "Content-Type": "application/json",
                            },
                            body: data);
                        Get.back();
                      },
                      child: const Text(
                        "전송",
                        style: LoginRegisterPageTheme.button,
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
*/