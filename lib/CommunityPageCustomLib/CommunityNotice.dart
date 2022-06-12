import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themeData.dart';

Container notice() {
  return Container(
    padding: EdgeInsets.only(
        left: Get.width * 0.05,
        right: Get.width * 0.05,
        bottom: Get.height * 0.012),
    decoration: const BoxDecoration(
        border: Border(
      bottom: BorderSide(width: 1, color: Colors.white),
    )),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          width: Get.width * 0.12,
          height: Get.width * 0.09,
          margin: EdgeInsets.only(right: Get.width * 0.015),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            "필독",
            style: CommunityPageTheme.announce,
          ),
        ),
        const Text(
          "도시농부 서비스 안내",
          style: CommunityPageTheme.announce,
        ),
      ],
    ),
  );
}
