import 'dart:convert';
import 'package:capstone/CommunityPage/CommunityPageMyActivity.dart';
import 'package:capstone/LoginPage/LoginPage.dart';
import 'package:capstone/MachinePage/MachinePageList.dart';
import 'package:capstone/MainPage/MainPageMyProfile.dart';
import 'package:capstone/MainPage/MainPageMyProfileEdit.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../CommunityPageCustomLib/CommunityFetch.dart';
import '../LoginPage/LoginPageLogin.dart';
import '../main.dart';

class NameController extends GetxController{
  final name = "".obs;
  void setName(String input){
    name.value = input;
  }
}

class AddressController extends GetxController{
  final zipcode = "".obs;
  final address1 = "".obs;
  final address2 = "".obs;
  final extraAddress = "".obs;

  void setAddress(String zip, String add1,String add2, String extraAdd){
    zipcode.value = zip;
    address1.value = add1;
    address2.value = add2;
    extraAddress.value = extraAdd;
  }
}

class PhoneNumberController extends GetxController{
  final phoneNumber = "".obs;
  void setPhoneNumber(String input){
    phoneNumber.value = input;
  }
}



Future<void> getProfile(String before) async {
  final nameController = Get.put(NameController());
  final addressController = Get.put(AddressController());
  final phoneNumberController = Get.put(PhoneNumberController());

  final response = await http.get(Uri.http(serverIP,
      '/api/my-page/info'),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Cookie": "JSESSIONID=$session",
      }
  );
  Map<String, dynamic> _user = jsonDecode(utf8.decode(response.bodyBytes));

  if(_user['name']!=null){
    nameController.setName(_user['name']);
  }
  if(_user['phoneNumber'] !=null && _user['phoneNumber']!=""){
    phoneNumberController.setPhoneNumber(_user['phoneNumber']);
  }else{
    phoneNumberController.setPhoneNumber("미등록");
  }
  if(_user['addressInfo']!=null){
    addressController.setAddress(
        _user['addressInfo']['zipcode'],
        _user['addressInfo']['address1'],
        _user['addressInfo']['address2'],
        _user['addressInfo']['extraAddress']);
  }

  switch(before){
    case "MainPageMyProfile":
      Get.to(()=>MainPageMyProfileEdit(user:_user));
      break;
    case "MainPageMyProfileEdit":
        Get.back();
      //Get.offAll(()=>CommunityPageForm(category: "ALL"));
      //Get.off(()=>MainPageMyProfile(user:_user, before: "MainPage",));
      break;
    case "CommunityPage":
      Get.to(()=>MainPageMyProfile(user:_user, before: "CommunityPage",));
      break;
    case "CommunityPageEdit":
      Get.to(()=>MainPageMyProfileEdit(user:_user,));
      break;
    default:
      Get.to(()=>MainPageMyProfile(user:_user, before: "MainPage",));
      break;
  }
  /*before=="MainPageMyProfile" ? Get.to(()=>MainPageMyProfileEdit(user:_user)) : Get.to(()=> MainPageMyProfile(user:_user));*/
}

class MainPageDrawer extends StatelessWidget {
  const MainPageDrawer({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
  double drawerPadding = MediaQuery.of(context).size.height*0.01;
  final nicknameController = Get.put(NicknameController());
  final tabController = Get.put(NewTabController());

  return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.075),
      color: MainColor.six,
      child: Column(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width*0.25,
            backgroundImage: profile?.image ?? const AssetImage("assets/images/profile.png"),
            /*backgroundImage: const AssetImage("assets/images/profile.png"),*/
          ),
          Container(
            margin: EdgeInsets.only(top: drawerPadding*2),
            alignment: Alignment.center,
            child: Column(
              children: [
                 Obx(()=>Text(
                  nicknameController.nickname.value,
                  style: nicknameController.nickname.value.length >7 ?  MainPageTheme.nameSub : MainPageTheme.name,
                )),
                Container(
                    padding:  EdgeInsets.only(top: drawerPadding/2),
                    child: TextButton(
                        child: const Text("내 정보",
                            style: MainPageTheme.modify),
                        onPressed: () async {
                          checkTimerController.time.value ?
                          checkTimerController.stop(context) : await getProfile("MainPage");
                        }
                        )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("소유한 기기 조회", style: MainPageTheme.drawerButton),
              onPressed: () {
                Get.to(()=>const MachinePageList());
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("작성 글 조회", style: MainPageTheme.drawerButton),
              onPressed: () {
                tabController.controller.index = 0;
                checkTimerController.time.value ?
                checkTimerController.stop(context) :   activityPostStartFetch().then((value)=>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>const CommunityPageMyActivity())));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("작성 댓글 조회", style: MainPageTheme.drawerButton),
              onPressed: () {
                tabController.controller.index = 1;
                checkTimerController.time.value ?
                checkTimerController.stop(context) :   activityCommentStartFetch().then((value)=>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>const CommunityPageMyActivity())));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("좋아요한 글 조회", style: MainPageTheme.drawerButton),
              onPressed: () {
                tabController.controller.index = 2;
                checkTimerController.time.value ?
                checkTimerController.stop(context) :   activityCommentStartFetch().then((value)=>
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) =>const CommunityPageMyActivity())));
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("구매내역 조회", style: MainPageTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("재배한 작물 조회", style: MainPageTheme.drawerButton),
              onPressed: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.all(drawerPadding),
            child: TextButton(
              child: const Text("로그아웃", style: MainPageTheme.drawerButton),
              onPressed: () {
                if(isLogin) {
                  FlutterNaverLogin.logOutAndDeleteToken();
                }
                Get.offAll(()=>const LoginPage(reLogin: false,));
              },
            ),
          )
        ],
      ),
    );
  }
}
