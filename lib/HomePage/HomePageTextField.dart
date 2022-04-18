import 'package:flutter/material.dart';

class HomePageTextField extends StatefulWidget {
  const HomePageTextField({Key? key}) : super(key: key);

  @override
  State<HomePageTextField> createState() => _HomePageTextFieldState();
}

class _HomePageTextFieldState extends State<HomePageTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.only(left: 15),
        color: const Color.fromRGBO(255, 255, 255, 100),//const Color.fromRGBO(196, 196, 196, 100),//const Color.fromRGBO(244, 230, 230, 100),
        width: MediaQuery.of(context).size.width * 0.75,
        child:  const TextField(

          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: 30),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: Icon(Icons.account_circle, size: 40,color: Colors.black,),
              hintText: "Username", hintStyle: TextStyle(fontSize: 30)),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.only(left: 15),
        color: const Color.fromRGBO(255, 255, 255, 100),//const Color.fromRGBO(196, 196, 196, 100),//const Color.fromRGBO(244, 230, 230, 100),
        width: MediaQuery.of(context).size.width * 0.75,
        child:  const TextField(
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: 30),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: Icon(Icons.lock, size: 40,color: Colors.black,),
              hintText: "Password", hintStyle: TextStyle(fontSize: 30)),
        ),
      ),
    ]
    );
  }
}
