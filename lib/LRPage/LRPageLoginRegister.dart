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

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
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
              child: const Text(
                "LOGIN",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
              ),
            ),
            const Text(
              "REGISTER",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
            ),
          ],
          indicator: const BoxDecoration(
            color: Colors.white,
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.white,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: TabBarView(controller: _tabController, children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.only(left: 15),
                  color: MainColor.sixty,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextField(
                    controller: _lUserNameController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 30),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(
                          Icons.account_circle,
                          size: 40,
                          color: Colors.black,
                        ),
                        hintText: "Username",
                        hintStyle: TextStyle(fontSize: 30)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.only(left: 15),
                  color: MainColor.sixty,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextField(
                    controller: _lPasswordController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 30),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(
                          Icons.lock,
                          size: 40,
                          color: Colors.black,
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 30)),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.only(left: 15),
                  color: MainColor.sixty,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextField(
                    controller: _rUserNameController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 30),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(
                          Icons.account_circle,
                          size: 40,
                          color: Colors.black,
                        ),
                        hintText: "Username",
                        hintStyle: TextStyle(fontSize: 30)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.only(left: 15),
                  color: MainColor.sixty,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextField(
                    controller: _rPasswordController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 30),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(
                          Icons.lock,
                          size: 40,
                          color: Colors.black,
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(fontSize: 30)),
                  ),
                ),
              ],
            ),
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(),
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.5,
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
        )
      ],
    );
  }
}
