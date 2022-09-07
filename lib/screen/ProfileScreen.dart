import 'package:capstone/model/Screen.dart';
import 'package:capstone/provider/Controller.dart';
import 'package:capstone/screen/CommunityScreen.dart';
import 'package:capstone/screen/MainScreen.dart';
import 'package:capstone/widget/CustomAppBar.dart';
import 'package:capstone/widget/FloatingWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/BoardType.dart';
import '../themeData.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final floatingController = Get.put(FloatingController());
    final userController = Get.put(UserController());
    final routeController = Get.put(RouteController());
    //final nicknameController = Get.put(NicknameController());

  /*  final nameController = Get.put(NameController());
    final phoneNumberController = Get.put(PhoneNumberController());
    final addressController = Get.put(AddressController());*/

    Future<bool> _onWillPop() async {
      //textField 비활성
      if(routeController.current.value == Screen.profileCommunity){
        routeController.setCurrent(Screen.community);
        Get.offAll(() => const CommunityScreen(boardType: BoardType.all));
      }else{
        routeController.setCurrent(Screen.main);
        Get.offAll(() => const MainScreen());
      }
      //Navigator.of(context).push(MaterialPageRoute(builder: (_) => CommunityReplyScreen(board: board)));

      //replyDetailController.replyDetailBefore.value == "ReadPost" ?
      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onDoubleTap: () {
          floatingController.toggle();
        },
        child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: Obx(()=>floatingController.floating.value ?
            FloatingWidget(type: routeController.current.value) : const SizedBox()),
          backgroundColor: MainColor.six,
          appBar: CustomAppBar(iconData: Icons.chevron_left,title: "도시농부",
            onPressed: () {
                floatingController.setUp();
                if(routeController.current.value == Screen.profileCommunity){
                  routeController.setCurrent(Screen.community);
                  Get.offAll(() => const CommunityScreen(boardType: BoardType.all));
                }else{
                  routeController.setCurrent(Screen.main);
                  Get.offAll(() => const MainScreen());
                }
            },home: true,),
          body: Column(
            children: [
              CircleAvatar(
                radius: MainSize.width * 0.22,
                backgroundImage: userController.user.value.picture?.image,
              ),
              Container(
                  margin: EdgeInsets.only(
                    top: MainSize.height * 0.018,),
                  //bottom: MediaQuery.of(context).size.height * 0.036),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Obx(()=>Text(
                        userController.user.value.nickname,
                        style: ProfilePageTheme.name,
                      ),
                      )
                    ],
                  )),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                      MainSize.width * 0.04,
                      MainSize.height * 0.024,
                      MainSize.width * 0.04,
                      0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: MainSize.height * 0.07),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              flex: 3,
                              child: Text("이메일", style: MainScreenTheme
                                  .profileField,),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                              userController.user.value.email.substring(0, userController.user.value.email
                                              .lastIndexOf('@')),
                                      style: MainScreenTheme.profileInfo,),
                                    Text(
                                      userController.user.value.email.substring(
                                          userController.user.value.email
                                              .lastIndexOf('@')),
                                      style: MainScreenTheme.profileInfo,),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: MainSize.height * 0.07),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              flex: 3,
                              child: Text("이름", style: MainScreenTheme
                                  .profileField,),
                            ),
                            Expanded(
                              flex: 5,
                              child: Obx(()=>Text(userController.user.value.name, style: MainScreenTheme
                                  .profileInfo,),),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: MainSize.height * 0.07),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Expanded(
                                flex: 3,
                                child: Text("전화번호", style: MainScreenTheme
                                    .profileField,),
                              ),
                              Expanded(
                                flex: 5,
                                child: Obx(()=>Text( userController.user.value.phoneNumber,
                                  style: MainScreenTheme.profileInfo,),),
                              ),
                            ]
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                              flex: 3,
                              child: Text(
                                "주소", style: MainScreenTheme.profileField,)),
                          Obx(()=>Expanded(
                            flex: 5,
                            child: userController.user.value.zipcode != "" ? Obx(()=>Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(userController.user.value.zipcode,
                                  style: MainScreenTheme.profileAddress,),
                                Text(userController.user.value.address1,
                                  style: MainScreenTheme.profileAddress,),
                                Text(userController.user.value.extraAddress,
                                  style: MainScreenTheme.profileAddress,),
                                Text(userController.user.value.address2,
                                  style: MainScreenTheme.profileAddress,),
                              ],
                            ),) : const Text("미등록", style: MainScreenTheme.profileInfo,),
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
