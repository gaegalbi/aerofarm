import 'package:capstone/MachinePage/MachinePageInfo.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MachinePageProfile extends StatefulWidget {
  const MachinePageProfile({Key? key}) : super(key: key);

  @override
  State<MachinePageProfile> createState() => _MachinePageProfileState();
}

class _MachinePageProfileState extends State<MachinePageProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MainColor.six,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
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
                Get.offAll(() => const MachinePageInfo());
              },
            ),
          )),
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
        child: Container(
          margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.37,
                      right: MediaQuery.of(context).size.width * 0.02,
                    ),
                    child: Center(
                      child: Column(
                        children: const [
                          Text(
                            "기기1",
                            style: MachinePage.profileText,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.drive_file_rename_outline_rounded,
                          color: MainColor.three,
                          size: 40,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.024 ),
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.35,
                  backgroundImage: const AssetImage("assets/images/3.png"),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.5,
                        top: MediaQuery.of(context).size.width * 0.5),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
