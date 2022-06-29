import 'package:capstone/main.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginPageRegister extends StatefulWidget {
  final bool reLogin;
  const LoginPageRegister({Key? key, required this.reLogin}) : super(key: key);

  @override
  State<LoginPageRegister> createState() => _LoginPageRegisterState();
}

class _LoginPageRegisterState extends State<LoginPageRegister> {
  late ScrollController _scrollController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;
  late TextEditingController _nickNameController;
  late TextEditingController _nameController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
   _passwordConfirmController = TextEditingController();
   _nickNameController = TextEditingController();
   _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nickNameController.dispose();
    _nameController.dispose();
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
                  Get.back();
                 // Get.off(()=> LoginPage(reLogin: widget.reLogin,));
                },
            )),
          ),
          title: const Text(
            "회원가입",
            style: LoginRegisterPageTheme.title,
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
                        "EMAIL ADDRESS",
                        style: LoginRegisterPageTheme.registerTitle,
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
                        style: LoginRegisterPageTheme.text,
                        //textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: MainColor.one,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "name@example.com",
                            hintStyle: LoginRegisterPageTheme.hint),
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
                        style: LoginRegisterPageTheme.registerTitle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        obscureText: true,
                        obscuringCharacter: "*",
                        controller: _passwordController,
                        textInputAction: TextInputAction.next,
                        style: LoginRegisterPageTheme.text,
                        //textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: MainColor.one,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintStyle: LoginRegisterPageTheme.hint),
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
                        "CONFIRM PASSWORD",
                        style: LoginRegisterPageTheme.registerTitle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        obscureText: true,
                        obscuringCharacter: "*",
                        controller: _passwordConfirmController,
                        textInputAction: TextInputAction.next,
                        style: LoginRegisterPageTheme.text,
                        //textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: MainColor.one,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintStyle: LoginRegisterPageTheme.hint),
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
                        "NAME",
                        style: LoginRegisterPageTheme.registerTitle,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: TextField(
                        controller: _nameController,
                        textInputAction: TextInputAction.next,
                        style: LoginRegisterPageTheme.text,
                        //textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: MainColor.one,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "홍길동",
                            hintStyle: LoginRegisterPageTheme.hint),
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
                        style: LoginRegisterPageTheme.registerTitle,
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
                        style: LoginRegisterPageTheme.text,
                        //textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: MainColor.one,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "NICKNAME을 입력해주세요",
                            hintStyle: LoginRegisterPageTheme.hint),
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
                    onPressed: () async {
                      //회원 가입
                      await http.post(Uri.http(ipv4, '/signup'),
                          body: {
                            "email":_emailController.text,
                            "password":_passwordController.text,
                            "confirmPassword":_passwordConfirmController.text,
                            "name":_nameController.text,
                            "nickname":_nickNameController.text
                          });
                      Get.back();
                      //Get.off(()=>LoginPage(reLogin: widget.reLogin,));
                    },
                    child: const Text(
                      "가입",
                      style: LoginRegisterPageTheme.button,
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
