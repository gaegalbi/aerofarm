import 'package:capstone/MachinePage/MachinePageInfo.dart';
import 'package:capstone/themeData.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../MainPage/MainPage.dart';

class MachinePageList extends StatefulWidget {
  const MachinePageList({Key? key}) : super(key: key);

  @override
  State<MachinePageList> createState() => _MachinePageListState();
}

class _MachinePageListState extends State<MachinePageList> {
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
                Get.off( const MainPage());
              },
            ),
          ),
        ),
        title: const Text(
          "도시농부",
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
                  Get.off( const MainPage());
                },
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: MainColor.six,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 10,
          // padding: EdgeInsets.only(bottom: 20),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.024, //20
                  left: MediaQuery.of(context).size.width * 0.03,
                  right: MediaQuery.of(context).size.width * 0.03),
              height: MediaQuery.of(context).size.height * 0.172,
              decoration: BoxDecoration(
                  color: MainColor.three,
                  borderRadius: BorderRadius.circular(45.0)),
              child: InkWell(
                borderRadius: BorderRadius.circular(45.0),
                onTap: () {
                  Get.off( const MachinePageInfo());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.022),
                            child: const Text(
                              "기기1",
                              style: MachinePageTheme.mName,
                            )),
                        const Text(
                          "재배작물 : 해바라기",
                          style: MachinePageTheme.mType,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.164,
                      backgroundImage: const AssetImage("assets/images/1.png"),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
