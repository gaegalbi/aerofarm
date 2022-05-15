import 'package:capstone/LoginPage/LoginPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPageRegister extends StatefulWidget {
  const LoginPageRegister({Key? key}) : super(key: key);

  @override
  State<LoginPageRegister> createState() => _LoginPageRegisterState();
}

class _LoginPageRegisterState extends State<LoginPageRegister> {
  late ScrollController _scrollController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  late TextEditingController _nickNameController;
  late TextEditingController _phoneNumberController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
   _passwordConfirmController = TextEditingController();
   _nickNameController = TextEditingController();
   _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nickNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double topMargin = MediaQuery.of(context).size.height * 0.03;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        //color: MainColor.ten,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MainColor.six,
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width * 0.2106,
          leading: Container(
            margin:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
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
                  Get.offAll(() => const LoginPage());
                },
            )),
          ),
          title: const Text(
            "회원가입",
            style: LrTheme.title,
          ),
        ),
        body: Container(
          color: MainColor.six,
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                          top: topMargin),
                      child: const Text(
                        "EMAILL ADDRESS",
                        style: LrTheme.registerTitle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        style: LrTheme.text,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: MainColor.one,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "name@example.com",
                            hintStyle: LrTheme.hint),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                          top: topMargin),
                      child: const Text(
                        "PASSWORD",
                        style: LrTheme.registerTitle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        //obscureText: true,
                        //obscuringCharacter: "*",
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                        style: LrTheme.text,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: MainColor.one,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintStyle: LrTheme.hint),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                          top: topMargin),
                      child: const Text(
                        "PASSWORD CONFIRM",
                        style: LrTheme.registerTitle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        //obscureText: true,
                        //obscuringCharacter: "*",
                        controller: _passwordConfirmController,
                        textInputAction: TextInputAction.next,
                        style: LrTheme.text,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: MainColor.one,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintStyle: LrTheme.hint),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                          top: topMargin),
                      child: const Text(
                        "NICKNAME",
                        style: LrTheme.registerTitle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _nickNameController,
                        textInputAction: TextInputAction.next,
                        style: LrTheme.text,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: MainColor.one,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "NICKNAME을 입력해주세요",
                            hintStyle: LrTheme.hint),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(
                          top: topMargin),
                      child: const Text(
                        "PHONE NUMBER",
                        style: LrTheme.registerTitle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _phoneNumberController,
                        textInputAction: TextInputAction.next,
                        style: LrTheme.text,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: MainColor.one,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "010-0000-0000",
                            hintStyle: LrTheme.hint),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.08),
                  color: MainColor.three,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextButton(
                    onPressed: () {
                      //회원 가입
                      Get.offAll(()=>const LoginPage());
                    },
                    child: const Text(
                      "가입",
                      style: LrTheme.button,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
