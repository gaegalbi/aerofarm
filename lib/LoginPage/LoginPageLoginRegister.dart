import 'package:capstone/LoginPage/LoginPageResetPassword.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageLoginRegister extends StatefulWidget {
  const LoginPageLoginRegister({Key? key}) : super(key: key);

  @override
  State<LoginPageLoginRegister> createState() => _LoginPageLoginRegisterState();
}

class _LoginPageLoginRegisterState extends State<LoginPageLoginRegister>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _lUserNameController;
  late TextEditingController _lPasswordController;
  late TextEditingController _rUserNameController;
  late TextEditingController _rPasswordController;

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tabController.addListener(() {
      _handleTabSelection();
    });
    _lUserNameController = TextEditingController();
    _lPasswordController = TextEditingController();
    _rUserNameController = TextEditingController();
    _rPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose(){
    _tabController.dispose();
    _lUserNameController.dispose();
    _lPasswordController.dispose();
    _rUserNameController.dispose();
    _rPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          tabs: [
            Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.06,
                child: Text(
                  "LOGIN",
                  style: _tabController.index == 0
                      ? LrTheme.button
                      : LrTheme.button1,
                )),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.06,
              child: Text(
                "REGISTER",
                style: _tabController.index == 1
                    ? LrTheme.button
                    : LrTheme.button1,
              ),
            ),
          ],
          indicator: const BoxDecoration(
            color: MainColor.three,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2167,
          child: TabBarView(controller: _tabController, children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.049),
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04),
                  color: MainColor.one,
                  width: MediaQuery.of(context).size.width * 0.696,
                  height: MediaQuery.of(context).size.height * 0.059,
                  child: TextField(
                    controller: _lUserNameController,
                    textInputAction: TextInputAction.next,
                    style: LrTheme.hint,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(
                          Icons.account_circle,
                          size: 40,
                          color: Colors.black,
                        ),
                        hintText: "Username",
                        hintStyle: LrTheme.hint),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.049),
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04),
                  color: MainColor.one,
                  width: MediaQuery.of(context).size.width * 0.696,
                  height: MediaQuery.of(context).size.height * 0.059,
                  child: TextField(
                    controller: _lPasswordController,
                    textInputAction: TextInputAction.next,
                    style: LrTheme.hint,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(
                          Icons.lock,
                          size: 40,
                          color: Colors.black,
                        ),
                        hintText: "Password",
                        hintStyle: LrTheme.hint),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.049),
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04),
                  color: MainColor.one,
                  width: MediaQuery.of(context).size.width * 0.696,
                  height: MediaQuery.of(context).size.height * 0.059,
                  child: TextField(
                    controller: _rUserNameController,
                    textInputAction: TextInputAction.next,
                    style: LrTheme.hint,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(
                          Icons.account_circle,
                          size: 40,
                          color: Colors.black,
                        ),
                        hintText: "Username",
                        hintStyle: LrTheme.hint),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.049),
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04),
                  color: MainColor.one,
                  width: MediaQuery.of(context).size.width * 0.696,
                  height: MediaQuery.of(context).size.height * 0.059,
                  child: TextField(
                    controller: _rPasswordController,
                    textInputAction: TextInputAction.next,
                    style: LrTheme.hint,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.transparent,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(
                          Icons.lock,
                          size: 40,
                          color: Colors.black,
                        ),
                        hintText: "Password",
                        hintStyle: LrTheme.hint),
                  ),
                ),
              ],
            ),
          ]),
        ),
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0369),
          color: MainColor.three,
          width: MediaQuery.of(context).size.width * 0.696,
          child: TextButton(
            child: const Text(
              "Continue",
              style: LrTheme.button,
            ),
            onPressed: () {
              //MainPage로 이동
              if (_tabController.index == 0) {
                if (_lUserNameController.text == "dd" &&
                    _lPasswordController.text == "12") {
                  Get.offAll(() => const MainPage());
                }
              } else {
                if (_rUserNameController.text == "dd") {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          content: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.03,
                              child: const Text(
                                "이미 있는 계정입니다.",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal),
                              )),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("확인",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black)),
                            ),
                          ],
                        );
                      });
                }
              }
            },
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03),
          child: Container(
            alignment: Alignment.center,
            child: TextButton(
              child: const Text(
                "비밀번호 재설정",
                style: LrTheme.sButton,
              ),
              onPressed: () {
                //LRPageResetPassword로 이동
                Get.off(() =>const LoginPageResetPassword());
              },
            ),
          ),
        ),
      ],
    );
  }
}
