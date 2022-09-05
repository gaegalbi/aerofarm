import 'dart:convert';

import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../model/Device.dart';

getDevices() async {
  final userController = Get.put(UserController());
  final deviceListController = Get.put(DeviceListController());
  deviceListController.setUp();

  final response = await http.get(Uri.http(serverIP,
      '/api/my-page/devices'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Cookie":"remember-me=${userController.user.value.rememberMe};JSESSIONID=${userController.user.value.session}",
      }
  );
  int i=0;
  while(true){
  //for(int i=0;i<5;i++){
    try {
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes))['content'][i];
      Device device = Device(data);
      deviceListController.addDevice(device);
      i++;
    } catch (error) {
      print(i);
      throw Exception(error);
      //print(error);
    }
  }



}