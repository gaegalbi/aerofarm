import 'package:capstone/widget/CustomTrackShape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../model/Device.dart';
import '../provider/Controller.dart';
import '../themeData.dart';

class DeviceOverlayScreen extends StatelessWidget {
  final Device device;

  const DeviceOverlayScreen({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceController = Get.put(DeviceController());
    deviceController.setUp(device);

    return Container(
      height: MainSize.height * 0.43,
      padding: EdgeInsets.only(
          left: MainSize.width * 0.1),
      color: MainColor.six,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: MainSize.width * 0.05),
                child: const Icon(
                  Icons.sunny,
                  size: 60,
                  color: MainColor.three,
                ),
              ),
              SizedBox(
                //width: MainSize.width*0.613,
                child: Row(
                  children: [
                    Obx(() => FlutterSwitch(
                        activeColor: MainColor.three,
                        inactiveColor: Colors.grey,
                        value: deviceController.ledOnOff.value,
                        onToggle: (value) {
                          deviceController.setLed(value);
                          device.ledOn = value;
                        },
                        height: MainSize.height * 0.05,
                      ),
                    ),
                    Obx(() => Container(
                         margin: EdgeInsets.only(left: MainSize.width * 0.1),
                            child: Text(
                          deviceController.ledOnOff.value ? "ON" : "OFF",
                          style: DeviceScreenTheme.led,
                        ))),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: MainSize.width * 0.05),
                child: const Icon(
                  TablerIcons.temperature_celsius,
                  size: 60,
                  color: MainColor.three,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Obx(
                  () => SliderTheme(
                    data: SliderThemeData(
                        trackShape: CustomTrackShape(),
                        tickMarkShape: SliderTickMarkShape.noTickMark,
                        trackHeight: 42,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: MainColor.three,
                        thumbColor: Colors.white,
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 10)),
                    child: Slider(
                        value: deviceController.temperature.value.toDouble(),
                        min: 0,
                        max: 100,
                        onChanged: (value) {
                          // deviceController.temperature.value = value.toInt();
                          deviceController.setTem(value.toInt());
                          device.temperature = value.toInt();
                        }),
                  ),
                ),
              ),
              Obx(() => Container(
                  margin: EdgeInsets.only(left: MainSize.width * 0.05),
                  child: Text(
                    deviceController.temperature.value.toString(),
                    style: DeviceScreenTheme.led,
                  ))),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: MainSize.width * 0.05),
                child: const Icon(
                  Icons.water_drop,
                  size: 60,
                  color: MainColor.three,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Obx(
                  () => SliderTheme(
                    data: SliderThemeData(
                        trackShape: CustomTrackShape(),
                        tickMarkShape: SliderTickMarkShape.noTickMark,
                        trackHeight: 42,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: MainColor.three,
                        thumbColor: Colors.white,
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 10)),
                    child: Slider(
                        value: deviceController.humidity.value.toDouble(),
                        min: 0,
                        max: 100,
                        onChanged: (value) {
                          deviceController.setHum(value.toInt());
                          device.humidity = value.toInt();
                        }),
                  ),
                ),
              ),
              Obx(() => Container(
                  margin: EdgeInsets.only(left: MainSize.width * 0.05),
                  child: Text(
                    deviceController.humidity.value.toString(),
                    style: DeviceScreenTheme.led,
                  ))),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: MainSize.width * 0.05),
                child: const ImageIcon(
                  AssetImage("assets/images/fertilizer.png"),
                  size: 60,
                  color: MainColor.three,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Obx(
                  () => SliderTheme(
                    data: SliderThemeData(
                        trackShape: CustomTrackShape(),
                        tickMarkShape: SliderTickMarkShape.noTickMark,
                        trackHeight: 42,
                        inactiveTrackColor: Colors.grey,
                        activeTrackColor: MainColor.three,
                        thumbColor: Colors.white,
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 10)),
                    child: Slider(
                        value: deviceController.fertilizer.value.toDouble(),
                        min: 0,
                        max: 100,
                        onChanged: (value) {
                          deviceController.setFer(value.toInt());
                          device.fertilizer = value.toInt();
                        }),
                  ),
                ),
              ),
              Obx(() => Container(
                  margin: EdgeInsets.only(left: MainSize.width * 0.05),
                  child: Text(
                    deviceController.fertilizer.value.toString(),
                    style: DeviceScreenTheme.led,
                  ))),
            ],
          )
        ],
      ),
    );
  }
}
