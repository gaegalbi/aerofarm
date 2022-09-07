import 'package:capstone/screen/RegisterScreen.dart';
import 'package:capstone/screen/ResetPasswordScreen.dart';
import 'package:capstone/themeData.dart';
import 'package:capstone/widget/CustomIconTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../service/login.dart';

class LoginScreen extends StatelessWidget {
  final bool reLogin;
  const LoginScreen({Key? key, required this.reLogin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Material(
      child: Padding(
        padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          color: MainColor.six,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "도시농부",
                style: LoginRegisterScreenTheme.title,
              ),
              Container(
                margin: EdgeInsets.only(bottom: MainSize.height *0.012,top: MainSize.height *0.012),
                width: MainSize.width * 0.36,//MediaQuery.of(context).size.width * 0.3973,
                height: MainSize.height * 0.14, //MediaQuery.of(context).size.height * 0.1834,
                child: Image.asset(
                  "assets/images/logo_blue.png",
                  fit: BoxFit.cover,
                ),
              ),
              Column(
                children: [
                  CustomIconTextField(controller: usernameController, icon: Icons.account_circle,hintText: "Username"),
                  CustomIconTextField(controller: passwordController, icon: Icons.key,hintText: "Password",),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top:MainSize.height * 0.025),
                  decoration: BoxDecoration(
                      color: MainColor.three,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  width: MainSize.width * 0.85,
                  height: MainSize.height* 0.059,
                child: TextButton(
                  onPressed: () {
                    login(usernameController,passwordController,context,reLogin);
                  },
                  child: const Text(
                    "도시농부 아이디로 로그인하기",
                    style: LoginRegisterScreenTheme.content,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: const Text(
                      "비밀번호 재설정",
                      style: LoginRegisterScreenTheme.sButton,
                    ),
                    onPressed: () {
                      Get.to(()=>const ResetPasswordScreen());
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(()=>const RegisterScreen());
                    },
                    child: const Text(
                      "회원이 아니신가요?",
                      style: LoginRegisterScreenTheme.sButton,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}