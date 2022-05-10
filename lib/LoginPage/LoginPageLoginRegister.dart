import 'package:capstone/LoginPage/LoginPageResetPassword.dart';
import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPageLoginRegister extends StatefulWidget {
  const LoginPageLoginRegister({Key? key}) : super(key: key);

  @override
  State<LoginPageLoginRegister> createState() => _LoginPageLoginRegisterState();
}

class _LoginPageLoginRegisterState extends State<LoginPageLoginRegister>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _lUserNameController;
  late TextEditingController _lPasswordController;
  late TextEditingController _rUserNameController;
  late TextEditingController _rPasswordController;

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tabController.addListener(() {
      _handleTabSelection();
    });
    _lUserNameController = TextEditingController();
    _lPasswordController = TextEditingController();
    _rUserNameController = TextEditingController();
    _rPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _lUserNameController.dispose();
    _lPasswordController.dispose();
    _rUserNameController.dispose();
    _rPasswordController.dispose();
    super.dispose();
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
              top: topMargin/2,
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
              style: LrTheme.hint,
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
              style: LrTheme.hint,
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
                  onPressed: () {},
                  child: const Text(
                    "회원이 아니신가요?",
                    style: LrTheme.sButton,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: topMargin, top: topMargin/4),
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
                  onPressed: () {},
                  icon: Image.asset("assets/kakao/kakao_circle.png"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: rightMargin),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
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
