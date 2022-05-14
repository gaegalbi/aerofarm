import 'package:flutter/material.dart';

import '../themeData.dart';

enum Type {
  pass,
  passCheck,
  phone1,
  phone2,
  phone3,
  email,
  add1,
  add2,
  zipCode
}


class MainPageMyProfileTextField extends StatefulWidget {
  final Type type;
  final double leftMargin;
  final TextEditingController controller;
  final double width;

  const MainPageMyProfileTextField({Key? key, required this.type,required this.leftMargin,required this.controller,required this.width})
      : super(key: key);

  @override
  State<MainPageMyProfileTextField> createState() =>
      _MainPageMyProfileTextFieldState();
}

class _MainPageMyProfileTextFieldState
    extends State<MainPageMyProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.03),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          typeText(widget.type),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width *
                   widget.leftMargin),
            width: MediaQuery.of(context).size.width * widget.width,
            height: MediaQuery.of(context).size.height * 0.04,
            child: TextField(
              controller: widget.controller,
              textInputAction: TextInputAction.next,
              style: LrTheme.hint,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                    bottom:
                    MediaQuery.of(context).size.height *
                        0.018,
                    left: MediaQuery.of(context).size.width *
                        0.04,
                    right: MediaQuery.of(context).size.width *
                        0.04),
                filled: true,
                fillColor: MainColor.one,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          )
        ],
      ),
    );
  }
}
Text typeText(Type type){
  switch(type){
    case Type.pass:
      return const Text(
        "비밀번호",
        style: ProfilePage.info,
        textAlign: TextAlign.left,
      );
    case Type.passCheck:
      return const Text(
        "비밀번호 확인",
        style: ProfilePage.info,
        textAlign: TextAlign.left,
      );
    case Type.phone1:
      return const Text(
        "전화번호",
        style: ProfilePage.info,
        textAlign: TextAlign.left,
      );
    case Type.email:
      return const Text(
        "이메일",
        style: ProfilePage.info,
        textAlign: TextAlign.left,
      );
    case Type.add1:
      return const Text(
        "주소",
        style: ProfilePage.info,
        textAlign: TextAlign.left,
      );
    default:
      return const Text('');
  }
}