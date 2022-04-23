import 'package:flutter/material.dart';
class MainPageTop extends StatefulWidget {
  const MainPageTop({Key? key}) : super(key: key);

  @override
  State<MainPageTop> createState() => _MainPageTopState();
}

class _MainPageTopState extends State<MainPageTop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Text(
        "도시농부",
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
