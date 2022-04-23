import 'package:capstone/MainPage/MainPageBottom.dart';
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
        title: Text(
          "도시농부",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: Colors.blue,//const Color.fromRGBO(205, 170, 170, 1),
        //padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            //MainPageTop(),
            MainPageBottom(),
          ],
        ),
      ),
    );
  }
}
