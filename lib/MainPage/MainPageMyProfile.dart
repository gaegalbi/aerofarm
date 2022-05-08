import 'package:capstone/CustomIcons.dart';
import 'package:capstone/MainPage/MainPage.dart';
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

  @override
  void initState() {
    _passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
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
              child: Builder(
            builder: (context) => IconButton(
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
          )),
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
      body: Container(
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
              height: MediaQuery.of(context).size.height * 0.44,
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.04,
                  MediaQuery.of(context).size.height * 0.024,
                  MediaQuery.of(context).size.width * 0.04,
                  0),
              child: Column(
                children: [
                  Container(
                    margin:EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          "비밀번호",
                          style: ProfilePage.info,
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.168),
                          width: MediaQuery.of(context).size.width * 0.46,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: TextField(
                            controller: _passController,
                            textInputAction: TextInputAction.next,
                            style: LrTheme.hint,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: MainColor.one,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin:EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          "비밀번호 확인",
                          style: ProfilePage.info,
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.035),
                          width: MediaQuery.of(context).size.width * 0.46,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: TextField(
                            controller: _passController,
                            textInputAction: TextInputAction.next,
                            style: LrTheme.hint,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: MainColor.one,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin:EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          "전화번호",
                          style: ProfilePage.info,
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.163),
                          width: MediaQuery.of(context).size.width * 0.46,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1328,
                                child: TextField(
                                  controller: _passController,
                                  textInputAction: TextInputAction.next,
                                  style: LrTheme.hint,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: MainColor.one,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width *
                                          0.002,
                                      right: MediaQuery.of(context).size.width *
                                          0.002),
                                  child: const Icon(
                                    CustomIcons.minus,
                                    size: 10,
                                    color: Colors.white,
                                  )),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1328,
                                child: TextField(
                                  controller: _passController,
                                  textInputAction: TextInputAction.next,
                                  style: LrTheme.hint,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: MainColor.one,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width * 0.002,
                                    right: MediaQuery.of(context).size.width *
                                        0.002),
                                child: const Icon(
                                  CustomIcons.minus,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.1328,
                                child: TextField(
                                  controller: _passController,
                                  textInputAction: TextInputAction.next,
                                  style: LrTheme.hint,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: MainColor.one,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin:EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Text(
                          "이메일",
                          style: ProfilePage.info,
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.135),
                          width: MediaQuery.of(context).size.width * 0.549,
                          height: MediaQuery.of(context).size.height * 0.04,
                          child: TextField(
                            controller: _passController,
                            textInputAction: TextInputAction.next,
                            style: LrTheme.hint,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: MainColor.one,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin:EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.03),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                          child: const Text(
                            "주소",
                            style: ProfilePage.info,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.061
                                ,bottom: MediaQuery.of(context).size.height * 0.01,
                              ),
                              width: MediaQuery.of(context).size.width * 0.52,
                              height: MediaQuery.of(context).size.height * 0.04,
                              child: TextField(
                                controller: _passController,
                                textInputAction: TextInputAction.next,
                                style: LrTheme.hint,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: MainColor.one,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 0.061
                                    ,),
                                  width: MediaQuery.of(context).size.width * 0.29,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child: TextField(
                                    controller: _passController,
                                    textInputAction: TextInputAction.next,
                                    style: LrTheme.hint,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: MainColor.one,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width * 0.056
                                    ,),
                                  width: MediaQuery.of(context).size.width * 0.173,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                  child: TextField(
                                    controller: _passController,
                                    textInputAction: TextInputAction.next,
                                    style: LrTheme.hint,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: MainColor.one,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.053
                          ,bottom:  MediaQuery.of(context).size.height * 0.05),
                          height: MediaQuery.of(context).size.height * 0.04,
                          alignment: Alignment.topCenter,
                          color: MainColor.three,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                              onPressed: () {},
                              child: const Text(
                                "검색",
                                style: ProfilePage.button,
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.04,
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
    );
  }
}
