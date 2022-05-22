import 'package:flutter/material.dart';

import '../themeData.dart';

class MainPageMyProfileAddress extends StatefulWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final TextEditingController controller3;

  const MainPageMyProfileAddress(
      {Key? key,
      required this.controller1,
      required this.controller2,
      required this.controller3})
      : super(key: key);

  @override
  State<MainPageMyProfileAddress> createState() =>
      _MainPageMyProfileAddressState();
}

class _MainPageMyProfileAddressState extends State<MainPageMyProfileAddress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.03),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.08,
            child: const Text(
              "주소",
              style: ProfilePageTheme.info,
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.061,
                  bottom: MediaQuery.of(context).size.height * 0.01,
                ),
                width: MediaQuery.of(context).size.width * 0.52,
                height: MediaQuery.of(context).size.height * 0.04,
                child: TextField(
                  controller: widget.controller1,
                  textInputAction: TextInputAction.next,
                  style: LoginRegisterPageTheme.hint,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.018,
                        left: MediaQuery.of(context).size.width * 0.04,
                        right: MediaQuery.of(context).size.width * 0.04),
                    filled: true,
                    fillColor: MainColor.one,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.061,
                    ),
                    width: MediaQuery.of(context).size.width * 0.29,
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: TextField(
                      controller: widget.controller2,
                      textInputAction: TextInputAction.next,
                      style: LoginRegisterPageTheme.hint,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.018,
                            left: MediaQuery.of(context).size.width * 0.04,
                            right: MediaQuery.of(context).size.width * 0.04),
                        filled: true,
                        fillColor: MainColor.one,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.056,
                    ),
                    width: MediaQuery.of(context).size.width * 0.173,
                    height: MediaQuery.of(context).size.height * 0.04,
                    child: TextField(
                      controller: widget.controller3,
                      textInputAction: TextInputAction.next,
                      style: LoginRegisterPageTheme.hint,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.018,
                            left: MediaQuery.of(context).size.width * 0.04,
                            right: MediaQuery.of(context).size.width * 0.04),
                        filled: true,
                        fillColor: MainColor.one,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.053,
                bottom: MediaQuery.of(context).size.height * 0.05),
            height: MediaQuery.of(context).size.height * 0.04,
            alignment: Alignment.topCenter,
            color: MainColor.three,
            child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: const Text(
                  "검색",
                  style: ProfilePageTheme.button,
                )),
          )
        ],
      ),
    );
  }
}
