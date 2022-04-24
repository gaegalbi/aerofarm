import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

class LRPageTop extends StatelessWidget {
  const LRPageTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: const Text(
            "도시농부",
            style: LrTheme.title,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          color: Colors.grey,
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Image.asset(
            "assets/images/logo.png",
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
