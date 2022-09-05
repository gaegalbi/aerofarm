import 'dart:convert';

import 'package:capstone/service/register.dart';
import 'package:capstone/widget/CustomAppBar.dart';
import 'package:capstone/widget/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themeData.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _passwordConfirmController = TextEditingController();
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _nicknameController = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: MainColor.six,
        //color: MainColor.ten,
        appBar: CustomAppBar(title: "회원가입", onPressed:(){ Get.back();},iconData: Icons.chevron_left,home: false,),
        body: SizedBox(
          width: MainSize.width,
          child: Column(
            children: [
              CustomRegisterTextField(title: 'EMAIL ADDRESS', controller: _emailController, hintText: "name@example.com",),
              CustomRegisterTextField(title:"PASSWORD",controller: _passwordController, hintText: ""),
              CustomRegisterTextField(title:"CONFIRM PASSWORD",controller: _passwordConfirmController, hintText: ""),
              CustomRegisterTextField(title:"NAME",controller: _nameController, hintText: "홍길동"),
              CustomRegisterTextField(title:"NICKNAME",controller: _nicknameController, hintText: "NICKNAME을 입력해주세요"),
              Container(
                margin: EdgeInsets.only(top: MainSize.height*0.03,),
                decoration: BoxDecoration(
                  color: MainColor.three,
                  borderRadius: BorderRadius.circular(10)
                ),
                width: MainSize.width * 0.8,
                height: MainSize.height * 0.06,
                child: TextButton(
                  onPressed: (){
                    register(_emailController, _nameController, _nicknameController, _passwordController, _passwordConfirmController, context);
                  },
                  child: const Text(
                    "가입",
                    style: LoginRegisterScreenTheme.button,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
