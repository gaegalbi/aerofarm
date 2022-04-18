import 'package:capstone/HomePage/HomePageLoginRegister.dart';
import 'package:flutter/material.dart';

class HomePageButton extends StatefulWidget {
  const HomePageButton({Key? key}) : super(key: key);

  @override
  State<HomePageButton> createState() => _HomePageButtonState();
}

class _HomePageButtonState extends State<HomePageButton> {
  @override
  Widget build(BuildContext context) {
    return
        Container(
          margin: const EdgeInsets.only(),
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 0.5,
          child: TextButton(
              onPressed: () {
              },
              child: Text(
                "Continue",
                style: Theme.of(context).textTheme.button,
              )),
        );
  }
}
