import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

int _sunnyCounter = 10;
int _temperatureCounter = 20;
int _humidityCounter = 30;
int _fertilizerCounter = 40;

class MachinePageOverlay extends StatefulWidget {
  const MachinePageOverlay({Key? key}) : super(key: key);

  @override
  State<MachinePageOverlay> createState() => _MachinePageOverlayState();
}

class _MachinePageOverlayState extends State<MachinePageOverlay> {
/*  late int _SunnyCounter;
  late int _TemperatureCounter;
  late int _HumidityCounter;
  late int _FertilizerCounter;*/

  @override
  void initState() {
    //db에서 가져오기
/*    _SunnyCounter = 10;
    _TemperatureCounter = 20;
    _HumidityCounter = 30;
    _FertilizerCounter = 40;*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.43,
      color: MainColor.six,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.sunny,
                size: 60,
                color: MainColor.three,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.613,
                child: SliderTheme(
                  data: SliderThemeData(
                      tickMarkShape: SliderTickMarkShape.noTickMark,
                      trackHeight: 42,
                      inactiveTrackColor: Colors.grey,
                      activeTrackColor: MainColor.three,
                      thumbColor: Colors.white,
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 10)),
                  child: Slider(
                      value: _sunnyCounter.toDouble(),
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          _sunnyCounter = value.toInt();
                        });
                      }),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                TablerIcons.temperature_celsius,
                size: 60,
                color: MainColor.three,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.613,
                child: SliderTheme(
                  data: SliderThemeData(
                      tickMarkShape: SliderTickMarkShape.noTickMark,
                      trackHeight: 42,
                      inactiveTrackColor: Colors.grey,
                      activeTrackColor: MainColor.three,
                      thumbColor: Colors.white,
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 10)),
                  child: Slider(
                      value: _temperatureCounter.toDouble(),
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          _temperatureCounter = value.toInt();
                        });
                      }),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.water_drop,
                size: 60,
                color: MainColor.three,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.613,
                child: SliderTheme(
                  data: SliderThemeData(
                      tickMarkShape: SliderTickMarkShape.noTickMark,
                      trackHeight: 42,
                      inactiveTrackColor: Colors.grey,
                      activeTrackColor: MainColor.three,
                      thumbColor: Colors.white,
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 10)),
                  child: Slider(
                      value: _humidityCounter.toDouble(),
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          _humidityCounter = value.toInt();
                        });
                      }),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ImageIcon(
                AssetImage("assets/images/fertilizer.png"),
                size: 60,
                color: MainColor.three,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.613,
                child: SliderTheme(
                  data: SliderThemeData(
                      tickMarkShape: SliderTickMarkShape.noTickMark,
                      trackHeight: 42,
                      inactiveTrackColor: Colors.grey,
                      activeTrackColor: MainColor.three,
                      thumbColor: Colors.white,
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 10)),
                  child: Slider(
                      value: _fertilizerCounter.toDouble(),
                      min: 0,
                      max: 100,
                      onChanged: (value) {
                        setState(() {
                          _fertilizerCounter = value.toInt();
                        });
                      }),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
