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
        appBar: AppBar(backgroundColor: MainColor.six,elevation: 0,),
        body: Container(
          color: MainColor.six,
            height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
              child: Column(
                children: const [
                  LoginPageTop(),
                  LoginPageLoginRegister(),
                ],
              ),
          ),
        ),
      ),
    );
  }
}
