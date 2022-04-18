import 'package:flutter/material.dart';
import 'package:capstone/HomePage/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: const TextTheme(
            subtitle1: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w900,
                fontSize: 50
            ),//HomePageTop(도시농부)
            button: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.none,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w900,
                fontSize: 25
            ),
          )
      ),
      home: const Scaffold(
        resizeToAvoidBottomInset: false, //keyboard 올라와도 overflow 발생 x
        body: HomePage(),
      ),
    );
  }
}
