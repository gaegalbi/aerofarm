import 'package:capstone/MainPage/MainPageBottom.dart';
import 'package:capstone/MainPage/MainPageDrawer.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
/*
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: MainPageTop(),
    );
  }
}*/

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
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: const Color.fromRGBO(93, 195, 121, 100) ,
        elevation: 0,
        title: const Text(
          "도시농부",
          style: MainTheme.title,
        ),
        actions: [
          Builder(
              builder: (context) => IconButton(
                padding: const EdgeInsets.only(right: 40),
                    icon: const Icon(Icons.menu, size: 50,),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ))
        ],
      ),
      endDrawer: const Drawer(
        child: MainPageDrawer(),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            MainPageBottom(),
          ],
        ),
      ),
    );
  }
}
