import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';

class MainPageBottom extends StatefulWidget {
  const MainPageBottom({Key? key}) : super(key: key);

  @override
  State<MainPageBottom> createState() => _MainPageBottomState();
}

class _MainPageBottomState extends State<MainPageBottom> {
  final _pageController = PageController();
  double _currentIndex = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
            children: [
          Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.55,
            child: PageView(
              controller: _pageController,
              children: <Widget>[
                Image.asset(
                  "assets/images/1.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/images/2.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "assets/images/3.png",
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            height: MediaQuery.of(context).size.height * 0.55,
            child: SliderIndicator(
              length: 3,
              activeIndex: _currentIndex.round(),
              indicator: const CircleAvatar(
                radius: 10,
                backgroundColor: MainColor.thirty,
              ),
              activeIndicator: CircleAvatar(
                radius: 10,
                backgroundColor: MainColor.sixty,
              )
            ),
          ),
        ]),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                //여기에 이미지로 채울꺼임
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.22,
                color: MainColor.sixty,
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "기기 관리",
                    style: MainTheme.button,
                  ),
                ),
              ),
              Container(
                //여기에 이미지로 채울꺼임
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.22,
                color: MainColor.sixty,
                alignment: Alignment.center,
                child: const Text(
                  "커뮤니티",
                  style: MainTheme.button,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
