import 'package:capstone/MachinePage/MachinePageOverlay.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../MainPage/MainPage.dart';
import 'MachinePageList.dart';
import 'MachinePageProfile.dart';

class MachinePageInfo extends StatefulWidget {
  const MachinePageInfo({Key? key}) : super(key: key);

  @override
  State<MachinePageInfo> createState() => _MachinePageInfoState();
}

class _MachinePageInfoState extends State<MachinePageInfo> {
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
              Get.off(()=>const MachinePageList());
            },
          )),
        ),
        title: const Text(
          "기기1",
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
                  Get.off(()=>const MainPage());
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
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.35,
                backgroundImage: const AssetImage("assets/images/1.png"),
              ),
            ),
            Container(
              height: 41,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.19,
                bottom: MediaQuery.of(context).size.height * 0.03,
              ),
              /*child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "상태 : ",
                    style: MachinePage.infoStatus,
                  ),
                  Text(
                    "양호",
                    style: TextStyle(
                        color: Colors.green, fontFamily: 'bmPro', fontSize: 40),
                  )
                ],
              ),*/
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.37,
                    right: MediaQuery.of(context).size.width * 0.06,
                  ),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return const MachinePageOverlay();
                            });
                      },
                      borderRadius: BorderRadius.circular(10.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.settings,
                            color: MainColor.three,
                            size: 100,
                          ),
                          Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.006),
                              child: const Text(
                                "설정값 편집",
                                style: MachinePageTheme.infoText,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.24,
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.06),
                  child: InkWell(
                    onTap: () {
                      Get.to(()=>const MachinePageProfile());
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.drive_file_rename_outline_rounded,
                          color: MainColor.three,
                          size: 60,
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.006),
                            child: const Text(
                              "프로필 편집",
                              style: MachinePageTheme.infoText,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
