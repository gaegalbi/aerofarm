import 'package:capstone/themeData.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
  final imageAssets = [
    "assets/images/1.png","assets/images/2.png","assets/images/3.png"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(alignment: Alignment.center, children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.55),

              itemCount: imageAssets.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                final sImage = imageAssets[index];
                return buildImage(sImage, index);
              },
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

  Widget buildImage(String sImage, int index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 12),
    color: Colors.grey,
    child: Image.asset(sImage, fit: BoxFit.cover,width: 375,),
  );
}