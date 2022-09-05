import 'package:capstone/screen/DeviceOverlayScreen.dart';
import 'package:capstone/screen/DeviceProfileScreen.dart';
import 'package:capstone/widget/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/Device.dart';
import '../themeData.dart';

class DeviceInfoScreen extends StatelessWidget {
  final Device device;
  const DeviceInfoScreen({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor.six,
      appBar: CustomAppBar(title: device.nickname,iconData: Icons.chevron_left,onPressed: (){Get.back();}, home: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: MainSize.height*0.2),
            child: CircleAvatar(
              radius: MainSize.width * 0.35,
              backgroundImage: Image.network(device.imageUrl).image,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MainSize.width*0.33,
              ),
              SizedBox(
                width: MainSize.width*0.33,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return DeviceOverlayScreen(device: device,);
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
                            style: DeviceScreenTheme.infoText,
                          ))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MainSize.width*0.33,
                child: InkWell(
                  onTap: () {
                    Get.to(()=>const DeviceProfileScreen());
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
                            style: DeviceScreenTheme.infoText,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
