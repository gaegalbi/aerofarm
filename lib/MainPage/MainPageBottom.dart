import 'package:flutter/material.dart';

class MainPageBottom extends StatefulWidget {
  const MainPageBottom({Key? key}) : super(key: key);

  @override
  State<MainPageBottom> createState() => _MainPageBottomState();
}

class _MainPageBottomState extends State<MainPageBottom> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            //여기에 이미지로 채울꺼임
            width: MediaQuery.of(context).size.width*0.45,
            height: MediaQuery.of(context).size.height*0.22,
            color: Colors.grey,
            alignment: Alignment.center,
            //margin: const EdgeInsets.fromLTRB(5, 15, 0, 15),
            child: const Text(
              "기기관리",
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          Container(
            //여기에 이미지로 채울꺼임
            width: MediaQuery.of(context).size.width*0.45,
            height: MediaQuery.of(context).size.height*0.22,
            color: Colors.grey,
            //margin: const EdgeInsets.fromLTRB(0, 15, 5, 15),
            alignment: Alignment.center,
            child: const Text(
              "커뮤니티",
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
