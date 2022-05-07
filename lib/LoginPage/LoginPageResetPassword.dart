import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

class LoginPageResetPassword extends StatefulWidget {
  const LoginPageResetPassword({Key? key}) : super(key: key);

  @override
  State<LoginPageResetPassword> createState() => _LoginPageResetPasswordState();
}

class _LoginPageResetPasswordState extends State<LoginPageResetPassword> {
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
    return Scaffold(
      //color: MainColor.ten,
      body: Center(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: Container(
            color: MainColor.ten,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.center,
            //color: MainColor.thirty,
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
                      style: LrTheme.title,
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
                            style: LrTheme.content,
                          )),
                      const Text(
                        "비밀번호 재설정 메일을 보내드립니다.",
                        style: LrTheme.content,
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
                      style: LrTheme.hint,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: MainColor.thirty,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "EMAIL을 입력해주세요",
                          hintStyle: LrTheme.hint),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.018),
                    color: MainColor.sixty,
                    child: TextButton(
                      onPressed: () {
                          //이메일 전송
                      },
                      child: const Text("전송",style: LrTheme.button,),
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
