import 'package:capstone/LRPage/LRPageLoginRegister.dart';
import 'package:capstone/LRPage/LRPageTop.dart';
import 'package:flutter/material.dart';


class LRPage extends StatefulWidget {
  const LRPage({Key? key}) : super(key: key);

  @override
  State<LRPage> createState() => _LRPageState();
}

class _LRPageState extends State<LRPage> {
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
          color: const Color.fromRGBO(186, 244, 111, 100),//const Color.fromRGBO(205, 170, 170, 1),
          //padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                LRPageTop(),
                LRPageLoginRegister(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
