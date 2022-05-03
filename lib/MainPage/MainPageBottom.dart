import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class MainPageBottom extends StatefulWidget {
  const MainPageBottom({Key? key}) : super(key: key);

  @override
  State<MainPageBottom> createState() => _MainPageBottomState();
}

class _MainPageBottomState extends State<MainPageBottom> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ImageSlideshow(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.55,
            initialPage: 0,
            autoPlayInterval: 3000,
            isLoop: true,
            children: [
                Image.asset("assets/images/1.png",fit: BoxFit.cover,),
                Image.asset("assets/images/2.png",fit: BoxFit.cover,),
                Image.asset("assets/images/3.png",fit: BoxFit.cover,),
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
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "커뮤니티",
                    style: MainTheme.button,
                  ),
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