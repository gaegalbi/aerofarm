import 'dart:math';

import 'package:capstone/CustomIcons.dart';
import 'package:capstone/LRPage/LRPageFindId.dart';
import 'package:capstone/LRPage/LRPageResetPassword.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

class LRPageLoginRegister extends StatefulWidget {
  const LRPageLoginRegister({Key? key}) : super(key: key);

  @override
  State<LRPageLoginRegister> createState() => _LRPageLoginRegisterState();
}

class _LRPageLoginRegisterState extends State<LRPageLoginRegister>
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
            color: MainColor.sixty,
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
                  color: MainColor.thirty,
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
                  color: MainColor.thirty,
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
                  color: MainColor.thirty,
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
                  color: MainColor.thirty,
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
          color: MainColor.sixty,
          width: MediaQuery.of(context).size.width * 0.696,
          child: TextButton(
            child: const Text(
              "Continue",
              style: LrTheme.button,
            ),
            onPressed: () {
              if (_tabController.index == 0) {
                if (_lUserNameController.text == "dd" &&
                    _lPasswordController.text == "12") {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const MainPage()),
                      (route) => false);
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
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0344),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    child: const Text(
                      "도시농부 계정 찾기",
                      style: LrTheme.sButton,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LRPageFindId()));
                    },
                  ),
                ),
              ),
              Transform.rotate(
                angle: 90 * pi / 180,
                child: const Icon(
                  CustomIcons.minus,
                  size: 13,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: const Text(
                      "비밀번호 재설정",
                      style: LrTheme.sButton,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const LRPageResetPassword()));
                    },
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
