import 'package:flutter/material.dart';

import '../CustomIcons.dart';
import '../themeData.dart';

class MainPageMyProfilePhone extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;
  const MainPageMyProfilePhone({Key? key, required this.controller1,required this.controller2,required this.controller3}) : super(key: key);

  @override
  State<MainPageMyProfilePhone> createState() => _MainPageMyProfilePhoneState();
}

class _MainPageMyProfilePhoneState extends State<MainPageMyProfilePhone> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.03),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            "전화번호",
            style: ProfilePage.info,
            textAlign: TextAlign.left,
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width *
                    0.163),
            width: MediaQuery.of(context).size.width * 0.46,
            height: MediaQuery.of(context).size.height * 0.04,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.1328,
                  child: TextField(
                    controller: widget.controller1,
                    textInputAction: TextInputAction.next,
                    style: LrTheme.hint,
                    maxLength: 3,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context)
                              .size
                              .height *
                              0.018,
                          left: MediaQuery.of(context)
                              .size
                              .width *
                              0.025,
                          right: MediaQuery.of(context)
                              .size
                              .width *
                              0.025),
                      filled: true,
                      fillColor: MainColor.one,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context)
                            .size
                            .width *
                            0.002,
                        right: MediaQuery.of(context)
                            .size
                            .width *
                            0.002),
                    child: const Icon(
                      CustomIcons.minus,
                      size: 10,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.1328,
                  child: TextField(
                    controller: widget.controller2,
                    textInputAction: TextInputAction.next,
                    style: LrTheme.hint,
                    maxLength: 4,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context)
                            .size
                            .height *
                            0.018,
                        left: MediaQuery.of(context)
                            .size
                            .width *
                            0.01,
                      ),
                      filled: true,
                      fillColor: MainColor.one,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left:
                      MediaQuery.of(context).size.width *
                          0.002,
                      right:
                      MediaQuery.of(context).size.width *
                          0.002),
                  child: const Icon(
                    CustomIcons.minus,
                    size: 10,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.1328,
                  child: TextField(
                    maxLength: 4,
                    controller: widget.controller3,
                    textInputAction: TextInputAction.next,
                    style: LrTheme.hint,
                    decoration: InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context)
                            .size
                            .height *
                            0.018,
                        left: MediaQuery.of(context)
                            .size
                            .width *
                            0.01,
                      ),
                      filled: true,
                      fillColor: MainColor.one,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
