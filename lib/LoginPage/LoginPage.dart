import 'package:capstone/LoginPage/LoginPageLoginRegister.dart';
import 'package:capstone/LoginPage/LoginPageTop.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        body: Container(
          color: MainColor.ten,
          child: Center(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: const [
                    LoginPageTop(),
                    LoginPageLoginRegister(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
