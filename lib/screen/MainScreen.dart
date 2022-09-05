import 'package:capstone/model/BoardType.dart';
import 'package:capstone/provider/Controller.dart';
import 'package:capstone/screen/CommunityScreen.dart';
import 'package:capstone/screen/DeviceListScreen.dart';
import 'package:capstone/widget/CustomAppBar.dart';
import 'package:capstone/widget/CustomDrawer.dart';
import 'package:capstone/widget/MainScreenBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import '../model/Screen.dart';
import '../themeData.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingController = Get.put(LoadingController());
    final routeController = Get.put(RouteController());
    final floatingController = Get.put(FloatingController());
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return Scaffold(
      key: _key,
      appBar: CustomAppBar( title: "도시농부",onPressed: (){_key.currentState!.openDrawer();},iconData: Icons.menu,home: false,),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width*0.75,
        child: const Drawer(
          backgroundColor: Colors.black,
          child: CustomMainDrawer(),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: MainColor.six,
        child: Column(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainScreenBox(text: "기기목록", route: (){
                    routeController.setCurrent(Screen.deviceList);
                    Get.to(()=>const DeviceListScreen(),);
                  }),
                  MainScreenBox(text: "커뮤니티", route: (){
                    floatingController.setUp();
                    loadingController.setTrue();
                    routeController.setCurrent(Screen.community);
                    Get.offAll(()=> const CommunityScreen(boardType: BoardType.all));}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}