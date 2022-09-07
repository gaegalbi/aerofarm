import 'package:capstone/widget/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themeData.dart';

class DeviceProfileScreen extends StatelessWidget {
  const DeviceProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(iconData: Icons.chevron_left,onPressed: (){Get.back();},home: true, title: '',),
      body: Container(
        color: MainColor.six,
        child: Container(
          margin:
          EdgeInsets.only(top: MainSize.height * 0.1),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: MainSize.width * 0.37,
                      right: MainSize.width * 0.02,
                    ),
                    child: Center(
                      child: Column(
                        children: const [
                          Text(
                            "기기1",
                            style: DeviceScreenTheme.profileText,
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
                margin: EdgeInsets.only(
                    top: MainSize.height * 0.024),
                child: CircleAvatar(
                  radius: MainSize.width * 0.35,
                  backgroundImage: const AssetImage("assets/images/1.png"),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: MainSize.width * 0.5,
                        top: MainSize.width * 0.5),
                    height: MainSize.width * 0.13,
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
