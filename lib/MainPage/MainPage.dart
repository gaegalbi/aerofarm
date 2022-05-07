import 'package:capstone/MainPage/MainPageBottom.dart';
import 'package:capstone/MainPage/MainPageDrawer.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        //foregroundColor: Colors.transparent,
        backgroundColor:MainColor.six,
        //backgroundColor: Colors.transparent,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        elevation: 0,
        leadingWidth: MediaQuery.of(context).size.width * 0.2106,
        leading: Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
          child: FittedBox(
              child: Builder(
            builder: (context) => IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              color: MainColor.three,
              iconSize: 50,
              // 패딩 설정
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.menu,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          )),
        ),
        title: const Text(
          "도시농부",
          style: MainTheme.title,
        ),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width*0.75,
        child: const Drawer(
          backgroundColor: Colors.black,
          child: MainPageDrawer(),
        ),
      ),
      body: Container(
        color: MainColor.six,
        child: Column(
          children: const [
            MainPageBottom(),
          ],
        ),
      ),
    );
  }
}
