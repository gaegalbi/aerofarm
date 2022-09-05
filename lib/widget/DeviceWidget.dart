import 'package:capstone/screen/DeviceInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/Device.dart';
import '../themeData.dart';

class DeviceWidget extends StatelessWidget {
  final Device device;
  const DeviceWidget({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: MainSize.height * 0.024, //20
          left: MainSize.width * 0.03,
          right: MainSize.width * 0.03),
      height: MainSize.height * 0.172,
      decoration: BoxDecoration(
          color: MainColor.three,
          borderRadius: BorderRadius.circular(45.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(45.0),
        onTap: () {
          Get.to(()=>DeviceInfoScreen(device: device,));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(
                        bottom: MainSize.height * 0.022),
                    child: Text(
                      device.nickname,
                      style: DeviceScreenTheme.mName,
                    )),
                Container(
                  margin: EdgeInsets.only(bottom: MainSize.height * 0.01),
                  child: Row(
                    children:  [
                      const Text("모델 : ",style:DeviceScreenTheme.mType,),
                      Text(device.model,  style: DeviceScreenTheme.mType,)
                    ],
                  ),
                ),
                Row(
                  children:  [
                    const Text("재배작물 : ",style:DeviceScreenTheme.mType,),
                    Text(device.plant,  style: DeviceScreenTheme.mType,)
                  ],
                )
              ],
            ),
            CircleAvatar(
              radius: MainSize.width * 0.164,
              backgroundImage: Image.network(device.imageUrl).image,
            )
          ],
        ),
      ),
    );
  }
}
