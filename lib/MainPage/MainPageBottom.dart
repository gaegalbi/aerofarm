import 'package:capstone/MachinePage/MachinePageList.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import '../CommunityPage/CommunityPageForm.dart';

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
            height: MediaQuery.of(context).size.height*0.555,
            initialPage: 0,
            autoPlayInterval: 3000,
            isLoop: true,
            children: [
                Image.asset("assets/images/1.png",fit: BoxFit.cover,),
                Image.asset("assets/images/2.png",fit: BoxFit.cover,),
                Image.asset("assets/images/3.png",fit: BoxFit.cover,),
        ]),
        Expanded(
          //margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.018,bottom:  MediaQuery.of(context).size.height*0.018), //15 //MediaQuery.of(context).size.height*0.018
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  //여기에 이미지로 채울꺼임
                  //width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height,//MediaQuery.of(context).size.height * 0.22,
                  margin: const EdgeInsets.only(left: 15,right: 5,top: 20,bottom: 20),
                  color: MainColor.three,
                  child: TextButton(
                    onPressed: () {
                      Get.to(()=>const MachinePageList(),);
                    },
                    child: const Text(
                      "기기목록",
                      style: MainPageTheme.button,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  //여기에 이미지로 채울꺼임
                  //width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height,//MediaQuery.of(context).size.height * 0.22,
                  margin: const EdgeInsets.only(left: 5,right: 15,top: 20,bottom: 20),
                  color: MainColor.three,
                  child: TextButton(
                    onPressed: () {
                     // fetch("all",false);
                      Get.offAll(()=> const CommunityPageForm(category:'all'));//beforeRouteController.before.value));
                    },
                    child: const Text(
                      "커뮤니티",
                      style: MainPageTheme.button,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}