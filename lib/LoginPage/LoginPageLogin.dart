import 'package:capstone/LoginPage/LoginPageRegister.dart';
import 'package:capstone/LoginPage/LoginPageResetPassword.dart';
import 'package:capstone/MainPage/MainPage.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

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
var name;
  var isLogin;
  Future<void> _naverLogin() async {
    NaverLoginResult res = await FlutterNaverLogin.logIn();
    setState(() {
       name = res.account.nickname;
       isLogin = true;
    });
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
            child: const Text(
              "도시농부 아이디로 로그인하기",
              style: LrTheme.content,
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
              style: LrTheme.text,
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
                  hintStyle: LrTheme.hint),
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
              style: LrTheme.text,
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
                  hintStyle: LrTheme.hint),
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
                    style: LrTheme.sButton,
                  ),
                  onPressed: () {
                    Get.to(() => const LoginPageResetPassword());
                  },
                ),
                TextButton(
                  onPressed: () {
                    Get.to(() => const LoginPageRegister());
                  },
                  child: const Text(
                    "회원이 아니신가요?",
                    style: LrTheme.sButton,
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
              style: LrTheme.sButton,
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
                        if (error is PlatformException && error.code == 'CANCELED') {
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
                onPressed: () {},
                icon: Image.asset("assets/google/google_circle.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
