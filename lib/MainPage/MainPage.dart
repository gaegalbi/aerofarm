import 'package:capstone/MainPage/MainPageTop.dart';
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
  late ScrollController _scrollController;

  @override
  void initState(){
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.75,
          alignment: Alignment.center,
          color: Colors.white,//const Color.fromRGBO(205, 170, 170, 1),
          //padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                MainPageTop(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
