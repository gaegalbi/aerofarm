import 'dart:convert';
import 'package:capstone/LoginPage/LoginPageRegister.dart';
import 'package:capstone/LoginPage/LoginPageResetPassword.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;

import '../CheckTimer.dart';
import '../main.dart';

late String? session;
late String name;
late bool isLogin = false;
late String? nickname;
//쿠키 받아두는 변수
late String? tmp;
late Image? profile;
final checkTimerController  = Get.put(CheckTimer());

class LoginPageLoginRegister extends StatefulWidget {
  final bool reLogin;
  const LoginPageLoginRegister({Key? key, required this.reLogin}) : super(key: key);

  @override
  State<LoginPageLoginRegister> createState() => _LoginPageLoginRegisterState();
}

class _LoginPageLoginRegisterState extends State<LoginPageLoginRegister> {
  late TextEditingController _lUserNameController;
  late TextEditingController _lPasswordController;
  final String _kakaoNative = 'cf0a2321116751cad7b6b470377c39b3';

  var data = <String, dynamic>{};

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
        nickname = res.account.nickname;
        nickname!.isEmpty ? isLogin = false : isLogin = true;
       // print(res.account.email);
        nickname!.isEmpty ? null : Get.offAll(()=>const MainPage());
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
                  final response = await http.get(
                    Uri.http(ipv4, '/login'),// Uri.http('172.25.4.179:8080', '/login'),//Uri.http('127.0.0.1:8080', '/login')
                  );
                  tmp = response.headers['set-cookie'];

                  session = tmp?.substring(tmp!.lastIndexOf('JSESSIONID')+11,tmp!.lastIndexOf('JSESSIONID')+43);

                  data = {
                    'email' :_lUserNameController.text,
                    'password' : _lPasswordController.text,
                    'remember-me' : "true"
                  };
                  final response1 = await http.post(
                    Uri.http(ipv4, '/login'),//Uri.http('172.25.4.179:8080', '/login'),
                    headers: {
                      "Content-Type": "application/x-www-form-urlencoded",
                      "Cookie":"JSESSIONID=$session",
                    },
                    encoding: Encoding.getByName('utf-8'),
                    body: data,
                  );
                  if(response1.statusCode ==200){
                    showDialog(context: context, builder: (context){
                      Future.delayed(const Duration(milliseconds: 1500), () {
                        Navigator.pop(context);
                      });
                      return const AlertDialog(
                        backgroundColor: Colors.transparent,
                        contentPadding: EdgeInsets.all(5),
                        content: Text("이메일이나 비밀번호가 잘못되었습니다.\n또는 이메일 인증을 진행해야 합니다.",style: TextStyle(fontSize: 30),textAlign: TextAlign.center,),
                      );
                    });
                    _lUserNameController.text="";
                    _lPasswordController.text="";
                    //팝업 띄우기
                  }else{
                    checkTimerController.timerClear();
                    checkTimerController.timerStart();
                    tmp = response1.headers['set-cookie'];
                    session = tmp?.substring(tmp!.lastIndexOf('JSESSIONID')+11,tmp!.lastIndexOf('JSESSIONID')+43);
                    final response = await http.get(
                      Uri.http(ipv4, ''),//Uri.http('172.25.4.179:8080', '')
                      headers: {
                        "Content-Type": "application/x-www-form-urlencoded",
                        "Cookie":"JSESSIONID=$session",
                      },
                    );
                    dom.Document document = parser.parse(response.body);
                    nickname = document
                        .querySelector('.nickname')
                        ?.text.substring(0,document.querySelector('.nickname')
                        ?.text.lastIndexOf('님'));
                    tmp = document.querySelector('.rounded-circle')?.outerHtml;
                    String? src = tmp!.substring(
                       tmp!.lastIndexOf("src")+5,
                       tmp!.lastIndexOf(".png")+4
                    );
                    //print(nickname);
                    //printWrapped(document.outerHtml);
                    profile = Image.network("http://$ipv4$src");

                    /*final response4 = await http.get(Uri.http(
                        ipv4,'/api/my-page/info'),
                        headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                    "Cookie":"JSESSIONID=$session",
                    }
                    );
                    printWrapped(response4.body);

                    성공 200번대
                    실패 400번대 post status찍어보기
                    */

                    widget.reLogin ?
                    Get.back() :
                    Get.offAll(()=>const MainPage());
                  }
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
                    profile = const Image(image: AssetImage("assets/images/profile.png"),);
                    _naverLogin();
                  },
                  icon: Image.asset("assets/naver/btnG_아이콘원형.png"),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () async {
                  try {
                    GoogleSignIn _googleSignIn = GoogleSignIn();
                    GoogleSignInAccount? _googleUser =
                        await _googleSignIn.signIn();
                    print(_googleUser?.email);
                    if (_googleUser != null) {
                      Get.to(()=>const MainPage());
                    }
                  } catch (error) {
                    print(error);
                  }
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
