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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor:MainColor.six,
        toolbarHeight: MainSize.toolbarHeight,
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
          style: MainScreenTheme.title,
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
        height: MediaQuery.of(context).size.height,
        color: MainColor.six,
        child: const MainPageBottom(),
      ),
    );
  }
}
