import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

class MainPageDrawer extends StatelessWidget {
  const MainPageDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.3,
          backgroundColor: MainColor.forty,
          child: Padding(
            padding: const EdgeInsets.all(10), // Border radius
            child: ClipOval(child: Image.asset("assets/images/logo.png")),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              const Text(
                "유저이름",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: TextButton(
                      child: const Text("내 정보 수정",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      onPressed: () {})),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(MainTheme.drawerPadding),
          child: TextButton(
            child: const Text("소유한 기기 조회", style: MainTheme.drawerButton),
            onPressed: () {},
          ),
        ),
        Container(
          padding: const EdgeInsets.all(MainTheme.drawerPadding),
          child: TextButton(
            child: const Text("작성 글 조회", style: MainTheme.drawerButton),
            onPressed: () {},
          ),
        ),
        Container(
          padding: const EdgeInsets.all(MainTheme.drawerPadding),
          child: TextButton(
            child: const Text("작성 댓글 조회", style: MainTheme.drawerButton),
            onPressed: () {},
          ),
        ),
        Container(
          padding: const EdgeInsets.all(MainTheme.drawerPadding),
          child: TextButton(
            child: const Text("기기 구매내역 조회", style: MainTheme.drawerButton),
            onPressed: () {},
          ),
        ),
        Container(
          padding: const EdgeInsets.all(MainTheme.drawerPadding),
          child: TextButton(
            child: const Text("재배한 작물 조회", style: MainTheme.drawerButton),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
