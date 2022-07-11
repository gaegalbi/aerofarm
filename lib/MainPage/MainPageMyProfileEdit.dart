import 'dart:convert';

import 'package:capstone/MainPage/MainPageDrawer.dart';
import 'package:capstone/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';
import 'package:http/http.dart' as http;
import '../LoginPage/LoginPageLogin.dart';
import '../themeData.dart';

class MainPageMyProfileEdit extends StatefulWidget {
  final Map<String,dynamic> user;
  const MainPageMyProfileEdit({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPageMyProfileEdit> createState() => _MainPageMyProfileEditState();
}

class _MainPageMyProfileEditState extends State<MainPageMyProfileEdit> {
  late TextEditingController _nicknameController;
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _address1Controller; //지번
  late TextEditingController _address2Controller; //상세주소 몇호
  late TextEditingController _extraAddressController; //(대명동)
  late TextEditingController _zipCodeController;
  final nicknameController = Get.put(NicknameController());
  PhoneNumberFormatter formatter = PhoneNumberFormatter();

  @override
  void initState(){
    _nicknameController = TextEditingController();
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _address1Controller = TextEditingController();
    _address2Controller = TextEditingController();
    _extraAddressController = TextEditingController();
    _zipCodeController = TextEditingController();
    _nicknameController.text = widget.user['nickname'];
    if(widget.user['name']!=null){
      _nameController.text = widget.user['name'];
    }
    if(widget.user['phoneNumber']!=null){
      _phoneNumberController.text = widget.user['phoneNumber'];
    }

    if(widget.user['addressInfo']!=null){
      if(widget.user['addressInfo']['extraAddress'] !=""){
        _extraAddressController.text = "(" + widget.user['addressInfo']['extraAddress'] +")";
      }
      _address1Controller.text = widget.user['addressInfo']['address1'];
      _address2Controller.text = widget.user['addressInfo']['address2'];
      _zipCodeController.text = widget.user['addressInfo']['zipcode'];
    }


    super.initState();
  }

  @override
  void dispose(){
    _nicknameController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: MainColor.six,
        appBar: AppBar(
          title: const Text("내 정보 수정",style: MainPageTheme.subTitle,),
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
                    if(_nicknameController.text.isEmpty){
                      showDialog(context: context, barrierDismissible:false,builder: (context){
                        Future.delayed(const Duration(milliseconds: 800),(){
                          Navigator.pop(context);
                        });
                        return const AlertDialog(
                          backgroundColor: Colors.transparent,
                          contentPadding: EdgeInsets.all(5),
                          content: Text("닉네임을 적어주세요.",style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
                        );
                      });
                    }else{
                      var data = {
                        "nickname":_nicknameController.text,
                        "name":_nameController.text,
                        "phoneNumber":_phoneNumberController.text,
                        "address1":_address1Controller.text,
                        "address2":_address2Controller.text,
                        "zipcode":_zipCodeController.text,
                        "extraAddress": _extraAddressController.text.isNotEmpty
                            ? _extraAddressController.text.substring(1,_extraAddressController.text.length-1)
                            : _extraAddressController.text
                      };
                      var body = jsonEncode(data);
                      final response = await http.post(Uri.http(serverIP, "/my-page/edit"),
                          headers:{
                            "Content-Type": "application/json",
                            "Cookie": "JSESSIONID=$session",
                          },
                          body: body);
                      Map<String,dynamic> status;
                      if(jsonDecode(utf8.decode(response.bodyBytes))['validation'] !=null) {
                        status = jsonDecode(utf8.decode(response.bodyBytes))['validation'];
                        switch(status.keys.first){
                          case "nickname":
                            print("nickname오류");
                            break;
                          case "phoneNumber":
                            print("phoneNumber오류");
                            break;
                          case "name":
                            //이름 다섯글자
                            print("name오류");
                            break;
                          default:
                            print(status.keys.first);
                            break;
                        }
                      }
                      //address1
                      //address2
                      nicknameController.setNickname(_nicknameController.text);
                      getProfile("MainPageMyProfileEdit");
                    }
                  },
                  child: const Text(
                    "등록",
                    style: CommunityPageTheme.postFont,
                  )),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.8,
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
                            child: const Text("프로필 사진",style: MainPageTheme.profileEditField,)),
                        CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.18,
                          backgroundImage: profile?.image ?? const AssetImage("assets/images/profile.png"),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("닉네임",style: MainPageTheme.profileEditField,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextField(
                            controller: _nicknameController,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: MainColor.one,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "닉네임",
                                hintStyle: LoginRegisterPageTheme.hint),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Text("이름",style: MainPageTheme.profileEditField,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: MainColor.one,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "이름",
                                hintStyle: LoginRegisterPageTheme.hint),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("연락처",style: MainPageTheme.profileEditField,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _phoneNumberController,
                            inputFormatters:  [
                              PhoneNumberFormatter(),],
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: MainColor.one,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "연락처",
                                hintStyle: LoginRegisterPageTheme.hint),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Text("우편번호",style: MainPageTheme.profileEditField,),
                        Row(
                          children: [
                             Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                                child: TextField(
                                  controller: _zipCodeController,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      enabled: false,
                                      fillColor: MainColor.one,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "우편번호",
                                      hintStyle: LoginRegisterPageTheme.hint),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.05,
                                margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05),
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
                                      style: MainPageTheme.profileMapButton,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const Text("주소",style: MainPageTheme.profileEditField,),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: TextField(
                            controller: _address1Controller,
                            decoration: const InputDecoration(
                              enabled: false,
                                filled: true,
                                fillColor: MainColor.one,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "주소",
                                hintStyle: LoginRegisterPageTheme.hint),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  [
                                const Text("상세주소",style: MainPageTheme.profileEditField,),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  child: TextField(
                                    controller: _address2Controller,
                                    decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: MainColor.one,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        hintText: "상세주소",
                                        hintStyle: LoginRegisterPageTheme.hint),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              const Text("참고항목",style: MainPageTheme.profileEditField,),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                                child: TextField(
                                  controller: _extraAddressController,
                                  decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: MainColor.one,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: "참고항목",
                                      hintStyle: LoginRegisterPageTheme.hint),
                                ),
                              ),
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

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length>13){
      return TextEditingValue(
        text: newValue.text.substring(0,newValue.text.length-1),
        selection: TextSelection.collapsed(
            offset: (newValue.text).length-1),
      );
    }else{
      if(newValue.text.length < oldValue.text.length){
        if(oldValue.text[oldValue.text.length-1] == "-"){
          return TextEditingValue(
            text: newValue.text.substring(0,newValue.text.length-1),
            selection: TextSelection.collapsed(
                offset: (newValue.text).length-1),
          );
        }else{
          return TextEditingValue(
            text: newValue.text,
            selection: TextSelection.collapsed(
                offset: (newValue.text).length),
          );
        }
      }else {
        if (oldValue.text.length == 2 || oldValue.text.length == 7) {
          return TextEditingValue(
            text: newValue.text + "-",
            selection: TextSelection.collapsed(
                offset: (newValue.text + "-").length),
          );
        }
        else {
          return newValue;
        }
      }
    }
  }
}