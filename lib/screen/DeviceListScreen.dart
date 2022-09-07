import 'package:capstone/provider/Controller.dart';
import 'package:capstone/service/getDevices.dart';
import 'package:capstone/widget/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themeData.dart';

class DeviceListScreen extends StatelessWidget {
  const DeviceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getDevices();
    final deviceListController = Get.put(DeviceListController());
    return Scaffold(
       backgroundColor: MainColor.six,
      appBar: CustomAppBar(title: "도시농부",iconData: Icons.chevron_left,onPressed: (){Get.back();},home: true,),
      body: Obx(()=>Column(
        children: deviceListController.deviceList,
      )),
    );
  }
}
