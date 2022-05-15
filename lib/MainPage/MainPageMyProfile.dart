import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/MainPage/MainPageMyProfileAddress.dart';
import 'package:capstone/MainPage/MainPageMyProfilePhone.dart';
import 'package:capstone/MainPage/MainPageMyProfileTextField.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageMyProfile extends StatefulWidget {
  const MainPageMyProfile({Key? key}) : super(key: key);

  @override
  State<MainPageMyProfile> createState() => _MainPageMyProfileState();
}

class _MainPageMyProfileState extends State<MainPageMyProfile> {
  late TextEditingController _passController;
  late TextEditingController _passCheckController;
  late TextEditingController _phone1Controller;
  late TextEditingController _phone2Controller;
  late TextEditingController _phone3Controller;
  late TextEditingController _emailController;
  late TextEditingController _add1Controller;
  late TextEditingController _add2Controller;
  late TextEditingController _zipCodeController;
  late ScrollController _scrollController;

  @override
  void initState() {
    _passController = TextEditingController();
    _passCheckController = TextEditingController();
    _phone1Controller = TextEditingController();
    _phone2Controller = TextEditingController();
    _phone3Controller = TextEditingController();
    _emailController = TextEditingController();
    _add1Controller = TextEditingController();
    _add2Controller = TextEditingController();
    _zipCodeController = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _passController.dispose();
    _passCheckController.dispose();
    _phone1Controller.dispose();
    _phone2Controller.dispose();
    _phone3Controller.dispose();
    _emailController.dispose();
    _add1Controller.dispose();
    _add2Controller.dispose();
    _zipCodeController.dispose();
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
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MainColor.six,
          toolbarHeight: MainSize.toobarHeight,
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
                  Get.off(() => const MainPage());
                },
              ),
            ),
          ),
          title: const Text(
            "도시농부",
            style: MainTheme.title,
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Builder(
                builder: (context) => IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  color: MainColor.three,
                  iconSize: 50,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.home,
                  ),
                  onPressed: () {
                    Get.off(() => const MainPage());
                  },
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: Container(
            color: MainColor.six,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.25,
                      backgroundImage:
                          const AssetImage("assets/images/profile.png"),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.35,
                            top: MediaQuery.of(context).size.width * 0.35),
                        height: MediaQuery.of(context).size.width * 0.13,
                        child: MaterialButton(
                          onPressed: () {
                            //프로필 이미지 수정
                          },
                          color: Colors.white,
                          padding: EdgeInsets.zero,
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.indigo,
                            size: 35,
                          ),
                          shape: const CircleBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.018),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "도시농부1",
                          style: ProfilePage.name,
                        ),
                        IconButton(
                            splashRadius: 20,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.drive_file_rename_outline_rounded,
                              size: 35,
                              color: MainColor.three,
                            ))
                      ],
                    )),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  margin: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * 0.04,
                      MediaQuery.of(context).size.height * 0.024,
                      MediaQuery.of(context).size.width * 0.04,
                      0),
                  child: Column(
                    children: [
                      MainPageMyProfileTextField(
                          type: Type.pass,
                          leftMargin: 0.168,
                          controller: _passController,
                          width: 0.46),
                      MainPageMyProfileTextField(
                          type: Type.passCheck,
                          leftMargin: 0.035,
                          controller: _passCheckController,
                          width: 0.46),
                      MainPageMyProfilePhone(
                          controller1: _phone1Controller,
                          controller2: _phone2Controller,
                          controller3: _phone3Controller),
                      MainPageMyProfileTextField(
                          type: Type.email,
                          leftMargin: 0.135,
                          controller: _emailController,
                          width: 0.549),
                      MainPageMyProfileAddress(
                          controller1: _add1Controller,
                          controller2: _add2Controller,
                          controller3: _zipCodeController),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.04,
                        //margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.06),
                        color: MainColor.three,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: () {},
                            child: const Text(
                              "수정",
                              style: ProfilePage.button,
                            )),
                      )
                    ],
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
