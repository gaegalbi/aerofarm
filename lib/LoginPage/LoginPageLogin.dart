import 'dart:convert';

import 'package:capstone/LoginPage/LoginPageRegister.dart';
import 'package:capstone/LoginPage/LoginPageResetPassword.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;


var name;
var isLogin;

class LoginPageLoginRegister extends StatefulWidget {
  const LoginPageLoginRegister({Key? key}) : super(key: key);

  @override
  State<LoginPageLoginRegister> createState() => _LoginPageLoginRegisterState();
}

class _LoginPageLoginRegisterState extends State<LoginPageLoginRegister> {
  late TextEditingController _lUserNameController;
  late TextEditingController _lPasswordController;
  final String _kakaoNative = 'cf0a2321116751cad7b6b470377c39b3';

  @override
  void initState() {
    _lUserNameController = TextEditingController();
    _lPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _lUserNameController.dispose();
    _lPasswordController.dispose();
    super.dispose();
  }

  Future<void> _naverLogin() async {
    try {
      NaverLoginResult res = await FlutterNaverLogin.logIn();
      setState(() {
        name = res.account.nickname;
        isLogin = true;
        print(res.account.email);
        Get.offAll(()=>const MainPage());
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    double topMargin = MediaQuery.of(context).size.height * 0.025;
    double rightMargin = MediaQuery.of(context).size.width * 0.04;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: topMargin / 2,
              left: topMargin,
              right: topMargin,
            ),
            color: MainColor.three,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.059,
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () async {
                try{
                  final response = await http
                      .get(Uri.http('127.0.0.1:8080', '/login'));
                  //dom.Document document = parser.parse(response.body);
                  //dom.Element? keywordElements = document.querySelector('.flutter-login');


                 //String? token = keywordElements?.outerHtml.substring(63,99);
                  String? session = response.headers['set-cookie']?.substring(11,43);

                  var map = <String, dynamic>{};
                  map['email'] = '217wjs@naver.com';
                  map['password'] = '12';
                  //map['_csrf'] = token;

                  final response1 = await http.post(
                    Uri.http('127.0.0.1:8080', '/login'),
                    headers: {
                      "Content-Type": "application/x-www-form-urlencoded",
                      "Cookie":"JSESSIONID=$session",
                    },
                    encoding: Encoding.getByName('utf-8'),
                    body: map,
                  );

                 /* print(token);
                  dom.Document document1 = parser.parse(response3.body);
                  dom.Element? keywordElements1 = document1.querySelector('._csrf');
                  //print(keywordElements1?.outerHtml);
                  token = keywordElements1?.outerHtml.substring(42,78);*/
                  //print(response1.headers);

                  session = response1.headers['set-cookie']?.substring(11,43);

                  //print(response1.headers);
                  //var headers = response1.headers;
                  //print(headers);
                  //print(session);
                  var map1 = <String, dynamic>{};
                  map1['category'] = "free";
                  map1['title'] = "플러터 글쓰기제목";
                  map1['contents'] = "플러터 글쓰기내용";
                  var body = json.encode(map1);

                  print(body);
                  //printWrapped(document2.outerHtml);
                  final response2 = await http.post(
                    Uri.http('127.0.0.1:8080', '/community/createPost'),
                    headers: {
                    "Content-Type": "application/json",
                    "Cookie":"JSESSIONID=$session",
                  },
                    encoding: Encoding.getByName('utf-8'),
                    body: body,
                  );
                  dom.Document document2 = parser.parse(response2.body);
                  print(document2.outerHtml);

                  //print(response1.body);
                  //print(keywordElements);
                  //printWrapped(response.body);
                  //print(response.body);
                  //print(response.headers);


                    //final authToken = cookies[1].split(';')[0]; //it depends on how your server sending cookie
                    //save this authToken in local storage, and pass in further api calls.

                    //aToken = authToken; //saving this to global variable to refresh current api calls to add cookie.
                    //print(authToken);


                  /*final response = await http
                      .get(Uri.http('172.25.2.57:8080', '/login'));
                  if (response.statusCode == 200) {
                    print(response.headers);
                  }else{
                    print("notwork");
                  }*/
                  /*final response = await http.post(
                    Uri.http('172.25.2.57:8080', '/community/createPost'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                      'Cookie': 'JSESSIONID=123123123'
                    },
                  );*/

                }catch(error){
                  print(error);
                }

              },
              child: const Text(
                "도시농부 아이디로 로그인하기",
                style: LoginRegisterPageTheme.content,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: topMargin),
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
            color: MainColor.one,
            width: MediaQuery.of(context).size.width * 0.696,
            height: MediaQuery.of(context).size.height * 0.059,
            child: TextField(
              controller: _lUserNameController,
              textInputAction: TextInputAction.next,
              style: LoginRegisterPageTheme.text,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  icon: Icon(
                    Icons.account_circle,
                    size: 40,
                    color: Colors.black,
                  ),
                  hintText: "Username",
                  hintStyle: LoginRegisterPageTheme.hint),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: topMargin),
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.04),
            color: MainColor.one,
            width: MediaQuery.of(context).size.width * 0.696,
            height: MediaQuery.of(context).size.height * 0.059,
            child: TextField(
              obscureText: true,
              obscuringCharacter: "*",
              controller: _lPasswordController,
              textInputAction: TextInputAction.next,
              style: LoginRegisterPageTheme.text,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  icon: Icon(
                    Icons.key,
                    size: 40,
                    color: Colors.black,
                  ),
                  hintText: "Password",
                  hintStyle: LoginRegisterPageTheme.hint),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: topMargin / 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text(
                    "비밀번호 재설정",
                    style: LoginRegisterPageTheme.sButton,
                  ),
                  onPressed: () {
                    Get.to(()=>const LoginPageResetPassword());
                  },
                ),
                TextButton(
                  onPressed: () {
                    Get.to(()=>const LoginPageRegister());
                  },
                  child: const Text(
                    "회원이 아니신가요?",
                    style: LoginRegisterPageTheme.sButton,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: topMargin, top: topMargin / 4),
            padding: EdgeInsets.only(top: topMargin),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 2, color: Colors.white),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "SNS계정으로 로그인",
              style: LoginRegisterPageTheme.sButton,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: rightMargin),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    KakaoSdk.init(nativeAppKey: _kakaoNative);
                    if (await isKakaoTalkInstalled()) {
                      try {
                        await UserApi.instance.loginWithKakaoTalk();
                        print('카카오톡으로 로그인 성공');
                      } catch (error) {
                        print('카카오톡으로 로그인 실패 $error');

                        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                        if (error is PlatformException &&
                            error.code == 'CANCELED') {
                          return;
                        }
                        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                        try {
                          await UserApi.instance.loginWithKakaoAccount();
                          print('카카오계정으로 로그인 성공');
                        } catch (error) {
                          print('카카오계정으로 로그인 실패 $error');
                        }
                      }
                    } else {
                      try {
                        await UserApi.instance.loginWithKakaoAccount();
                        print('카카오계정으로 로그인 성공');
                        User user = await UserApi.instance.me();
                        print(user.kakaoAccount?.email);
                        Get.to(()=>const MainPage());
                      } catch (error) {
                        print('카카오계정으로 로그인 실패 $error');
                      }
                    }
                  },
                  icon: Image.asset("assets/kakao/kakao_circle.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: rightMargin),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _naverLogin();
                  },
                  icon: Image.asset("assets/naver/btnG_아이콘원형.png"),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  launchUrl(
                    Uri.parse('http://localhost:8080/oauth2/authorization/google'),
                  );
                /*  http.Response _res = await http.get(
                    Uri.http('172.25.2.57:8080', 'login/oauth2/code/google'),
                   // Uri.http('172.25.2.57:8080', '/login'),
                  );
                  print(_res);*/
                  //http://127.0.0.1:8080/login/oauth2/code/google
                  /*try {
                    GoogleSignIn _googleSignIn = GoogleSignIn();
                    GoogleSignInAccount? _googleUser =
                        await _googleSignIn.signIn();
                    print(_googleUser?.email);
                    if (_googleUser != null) {
                      Get.to(()=>const MainPage());
                    }
                  } catch (error) {
                    print(error);
                  }*/
                },
                icon: Image.asset("assets/google/google_circle.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
