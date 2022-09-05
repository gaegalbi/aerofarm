import 'package:capstone/provider/Controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/Screen.dart';
import '../screen/MainScreen.dart';
import '../themeData.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData iconData;
  final bool home;
  const CustomAppBar({Key? key, required this.title, required this.onPressed, required this.iconData, required this.home}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(MainSize.toolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    final routeController = Get.put(RouteController());

    return AppBar(
      centerTitle: true,
      backgroundColor: MainColor.six,
      elevation: 0,
      leadingWidth: MediaQuery.of(context).size.width * 0.2106,
      leading: Container(
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05),
          child: FittedBox(
            child: IconButton(
              splashRadius: 25,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              color: MainColor.three,
              iconSize: 50,
              // 패딩 설정
              constraints: const BoxConstraints(),
              icon: Icon(
                widget.iconData,
              ),
              onPressed: widget.onPressed,
            ),
          )),
      title: Text(
        widget.title,
        style: LoginRegisterScreenTheme.title,
      ),
       actions: [
         widget.home ? Container(
           margin: EdgeInsets.only(
               right: MediaQuery.of(context).size.width * 0.05),
           child: Builder(
             builder: (context) =>
                 IconButton(
                   padding: EdgeInsets.zero,
                   alignment: Alignment.center,
                   color: MainColor.three,
                   iconSize: 50,
                   constraints: const BoxConstraints(),
                   icon: const Icon(
                     Icons.home,
                   ),
                   onPressed: () {
                     routeController.setCurrent(Screen.main);
                     Get.off(() => const MainScreen());
                   },
                 ),
           ),
         ):Container()
       ]
    );
  }
}


class CustomProfileEditAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData iconData;
  final bool home;
  const CustomProfileEditAppBar({Key? key, required this.title, required this.onPressed, required this.iconData, required this.home}) : super(key: key);

  @override
  State<CustomProfileEditAppBar> createState() => _CustomProfileEditAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(MainSize.toolbarHeight);
}

class _CustomProfileEditAppBarState extends State<CustomProfileEditAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: MainColor.six,
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width * 0.2106,
        leading: Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.05),
            child: FittedBox(
              child: IconButton(
                splashRadius: 25,
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                color: MainColor.three,
                iconSize: 50,
                // 패딩 설정
                constraints: const BoxConstraints(),
                icon: Icon(
                  widget.iconData,
                ),
                onPressed: widget.onPressed,
              ),
            )),
        title: Text(
          widget.title,
          style: LoginRegisterScreenTheme.title,
        ),
        actions: [
          widget.home ? Container(
            margin: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.05),
            child: Builder(
              builder: (context) =>
                  IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    color: MainColor.three,
                    iconSize: 50,
                    constraints: const BoxConstraints(),
                    icon: const Icon(
                      Icons.home,
                    ),
                    onPressed: () {
                      Get.off(() => const MainScreen());
                    },
                  ),
            ),
          ):Container()
        ]
    );
  }
}
/*

AppBar(
title: const Text(
"내 정보 수정",
style: MainPageTheme.subTitle,
),
toolbarHeight: MainSize.toolbarHeight / 2,
elevation: 0,
backgroundColor: MainColor.six,
leading: IconButton(
padding: EdgeInsets.zero,
onPressed: () {
FocusScope.of(context).unfocus();
Future.delayed(const Duration(milliseconds: 150), () {
Get.back();
});
},
icon: const Icon(Icons.close),
),
actions: [
Container(
margin: EdgeInsets.only(right: 15),
decoration: BoxDecoration(
color: MainColor.three,
borderRadius: BorderRadius.circular(10.0),
),
child: TextButton(
onPressed: () async {},
child: const Text(
"등록",
style: CommunityPageTheme.postFont,
)),
)
],
)*/
