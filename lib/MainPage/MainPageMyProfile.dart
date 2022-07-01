import 'package:capstone/CommunityPage/CommunityPageFloating.dart';
import 'package:capstone/LoginPage/LoginPageLogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themeData.dart';
import 'MainPage.dart';


class MainPageMyProfile extends StatefulWidget {
  final Map<String,dynamic> user;
  final String before;
  const MainPageMyProfile({Key? key, required this.user, required this.before}) : super(key: key);

  @override
  State<MainPageMyProfile> createState() => _MainPageMyProfileState();
}

class _MainPageMyProfileState extends State<MainPageMyProfile> {
  bool floating = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: (){
        setState((){
          floating =! floating;
        });
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: floating? CommunityPageFloating(type: widget.before =="MainPage" ? "Profile" : "CommunityProfile", keywords: {}, before: "") : null,
        backgroundColor: MainColor.six,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MainColor.six,
          toolbarHeight: MainSize.toolbarHeight,
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width * 0.2106,
          leading: Container(
            margin:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: FittedBox(
              child: IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                color: MainColor.three,
                iconSize: 50,
                // 패딩 설정
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.chevron_left,
                ),
                onPressed: () {
                  Get.back();
                 /* Get.off(()=>const MainPage());*/
                },
              ),
            ),
          ),
          title: const Text(
            "도시농부",
            style: MainPageTheme.title,
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Builder(
                builder: (context) => IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  color: MainColor.three,
                  iconSize: 50,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.home,
                  ),
                  onPressed: () {
                    Get.off(()=>const MainPage());
                  },
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.25,
              backgroundImage: profile?.image ?? const AssetImage("assets/images/profile.png"),
            ),
            Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.018,),
                //bottom: MediaQuery.of(context).size.height * 0.036),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.user['nickname'],
                      style: ProfilePageTheme.name,
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.04,
                  MediaQuery.of(context).size.height * 0.024,
                  MediaQuery.of(context).size.width * 0.04,
                  0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                            child: const Text("이메일",style: MainPageTheme.profileField,)),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Text("217wjs",style: MainPageTheme.profileInfo,),
                                  Text(widget.user['email'].toString().substring(0,widget.user['email'].toString().lastIndexOf('@')),style: MainPageTheme.profileInfo,),
                                  Text(widget.user['email'].toString().substring(widget.user['email'].toString().lastIndexOf('@')),style: MainPageTheme.profileInfo,),
                                ])),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                            child: const Text("이름",style: MainPageTheme.profileField,)),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                            child:Text(widget.user['name']==null ? "admin" : (widget.user['name']=="") ? "미등록" : widget.user['name'],style: MainPageTheme.profileInfo,)),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                              child: const Text("전화번호",style: MainPageTheme.profileField,)),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                              child: Text(widget.user['phoneNumber']=="" ?  "미등록" : widget.user['phoneNumber'],style: MainPageTheme.profileInfo,)),
                        ),
                      ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex:3,
                          child: Text("주소",style: MainPageTheme.profileField,)),
                      Expanded(
                        flex: 5,
                        child: widget.user['addressInfo']==null ?
                        const Text("관리자 계정입니다.",style: MainPageTheme.profileInfo)
                            : (widget.user['addressInfo']==" " || widget.user['addressInfo']['zipcode'] == "")
                            ? const Text("미등록",style: MainPageTheme.profileInfo,)
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.user['addressInfo']['zipcode'],style: MainPageTheme.profileAddress, ),
                            Text(widget.user['addressInfo']['address1'],style: MainPageTheme.profileAddress, ),
                            Text(widget.user['addressInfo']['extraAddress'].toString().substring(1),style: MainPageTheme.profileAddress, ),
                            Text(widget.user['addressInfo']['address2'],style: MainPageTheme.profileAddress, ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/*
class MainPageMyProfile extends StatelessWidget {
  final Map<String,dynamic> user;
  const MainPageMyProfile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool floating = false;

    return GestureDetector(
      onDoubleTap: (){
        floating =! floating;
      },
      child: Scaffold(
        floatingActionButton: floating? CommunityPageFloating(type: "Profile", keywords: {}, before: "") : null,
        backgroundColor: MainColor.six,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MainColor.six,
          toolbarHeight: MainSize.toobarHeight,
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width * 0.2106,
          leading: Container(
            margin:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
            child: FittedBox(
              child: IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                color: MainColor.three,
                iconSize: 50,
                // 패딩 설정
                constraints: const BoxConstraints(),
                icon: const Icon(
                  Icons.chevron_left,
                ),
                onPressed: () {
                  Get.off(()=>const MainPage());
                },
              ),
            ),
          ),
          title: const Text(
            "도시농부",
            style: MainPageTheme.title,
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05),
              child: Builder(
                builder: (context) => IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  color: MainColor.three,
                  iconSize: 50,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.home,
                  ),
                  onPressed: () {
                    Get.off(()=>const MainPage());
                  },
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.25,
                  backgroundImage: profile?.image ?? const AssetImage("assets/images/profile.png"),
                ),
                Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.018,),
                    //bottom: MediaQuery.of(context).size.height * 0.036),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user['nickname'],
                          style: ProfilePageTheme.name,
                        ),
                      ],
                    )),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.04,
                  MediaQuery.of(context).size.height * 0.024,
                  MediaQuery.of(context).size.width * 0.04,
                  0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                            child: const Text("이메일",style: MainPageTheme.profileField,)),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Text("217wjs",style: MainPageTheme.profileInfo,),
                                  Text(user['email'].toString().substring(0,user['email'].toString().lastIndexOf('@')),style: MainPageTheme.profileInfo,),
                                  Text(user['email'].toString().substring(user['email'].toString().lastIndexOf('@')),style: MainPageTheme.profileInfo,),
                                ])),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                            child: const Text("이름",style: MainPageTheme.profileField,)),
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                            child:Text(user['name']=="" ? "미등록" : user['name'],style: MainPageTheme.profileInfo,)),
                      ),
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                              child: const Text("전화번호",style: MainPageTheme.profileField,)),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                              margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.05),
                              child: Text(user['phoneNumber']=="" ?  "미등록" : user['phoneNumber'],style: MainPageTheme.profileInfo,)),
                        ),
                      ]
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                          flex:3,
                          child: Text("주소",style: MainPageTheme.profileField,)),
                      Expanded(
                        flex: 5,
                        child: (user['addressInfo']==" " || user['addressInfo']['zipcode'] == "")
                            ? const Text("미등록",style: MainPageTheme.profileInfo,) :
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user['addressInfo']['zipcode'],style: MainPageTheme.profilePhoneNumber, ),
                            Text(user['addressInfo']['address1'],style: MainPageTheme.profilePhoneNumber, ),
                            Text(user['addressInfo']['extraAddress'].toString().substring(1),style: MainPageTheme.profilePhoneNumber, ),
                            Text(user['addressInfo']['address2'],style: MainPageTheme.profilePhoneNumber, ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}*/
