import 'package:capstone/provider/Controller.dart';
import 'package:capstone/service/editProfile.dart';
import 'package:capstone/widget/ProfileEditColumn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';
import '../themeData.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  final userController = Get.put(UserController());
  final _nicknameController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _address1Controller = TextEditingController();
  final _address2Controller = TextEditingController();
  final _extraAddressController = TextEditingController();
  final _zipCodeController = TextEditingController();

  @override
  initState() {
    _nicknameController.text = userController.user.value.nickname;
    if (userController.user.value.name != "미등록") {
      _nameController.text = userController.user.value.name;
    }
    if (userController.user.value.phoneNumber != "미등록") {
      _phoneNumberController.text = userController.user.value.phoneNumber;
    }
    _zipCodeController.text = userController.user.value.zipcode;
    _address1Controller.text = userController.user.value.address1;
    _address2Controller.text = userController.user.value.address2;
    _extraAddressController.text = userController.user.value.extraAddress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: MainColor.six,
        appBar: AppBar(
          title: const Text(
            "내 정보 수정",
            style: MainScreenTheme.subTitle,
          ),
          toolbarHeight: MainSize.toolbarHeight / 2,
          elevation: 0,
          backgroundColor: MainColor.six,
          leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              FocusScope.of(context).unfocus();
              Future.delayed(const Duration(milliseconds: 150), () {
                Get.back();
              });
            },
            icon: const Icon(Icons.close),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                color: MainColor.three,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextButton(
                  onPressed: () async {
                    editProfile(context, _nicknameController,
                        _nameController, _phoneNumberController,
                        _address1Controller, _address2Controller, _extraAddressController, _zipCodeController);
                  },
                  child: const Text(
                    "등록",
                    style: CommunityScreenTheme.postFont,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.8,
                margin: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.04,
                    0,
                    MediaQuery.of(context).size.width * 0.04,
                    0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "프로필 사진",
                              style: MainScreenTheme.profileEditField,
                            )),
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.18,
                          backgroundImage:
                              userController.user.value.picture?.image,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.23,
                                top: MediaQuery.of(context).size.width * 0.23),
                            height: MediaQuery.of(context).size.width * 0.13,
                            child: MaterialButton(
                              onPressed: () {
                                //프로필 이미지 수정
                              },
                              color: Colors.white,
                              padding: EdgeInsets.zero,
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.indigo,
                                size: 35,
                              ),
                              shape: const CircleBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ProfileEditColumn(controller: _nicknameController, text: "닉네임",number: false,),
                    ProfileEditColumn(controller: _nameController, text: "이름",number: false,),
                    ProfileEditColumn(controller: _phoneNumberController, text: "연락처", number: true),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "우편번호",
                          style: MainScreenTheme.profileEditField,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child:Container(
                                decoration: BoxDecoration(
                                    color: MainColor.one,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: TextField(
                                  controller: _zipCodeController,
                                  decoration: custom("우편번호"),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.05),
                                decoration: BoxDecoration(
                                  color: MainColor.three,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: TextButton(
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => KpostalView(
                                            useLocalServer: false,
                                            localPort: 1024,
                                            callback: (Kpostal result) {
                                              setState(() {
                                                _zipCodeController.text = result.postCode;
                                                _address1Controller.text = result.address;
                                                _extraAddressController.text = "(" + result.bname + ")";
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "우편번호 찾기",
                                      style: MainScreenTheme.profileMapButton,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ProfileEditColumn(controller: _address1Controller, text: "주소", number: false),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                right:
                                    MediaQuery.of(context).size.width * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "상세주소",
                                  style: MainScreenTheme.profileEditField,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: MainColor.one,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: TextField(
                                    controller: _address2Controller,
                                    decoration: custom("상세주소"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "참고항목",
                                style: MainScreenTheme.profileEditField,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: MainColor.one,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: TextField(
                                  controller: _extraAddressController,
                                  decoration: custom("참고항목"),
                              ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
