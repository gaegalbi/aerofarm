import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

class LRPageResetPassword extends StatefulWidget {
  const LRPageResetPassword({Key? key}) : super(key: key);

  @override
  State<LRPageResetPassword> createState() => _LRPageResetPasswordState();
}

class _LRPageResetPasswordState extends State<LRPageResetPassword> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.75,
            alignment: Alignment.center,
            color: MainColor.thirty,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Container(
                    child: Text("도시농부",style: LrTheme.title,),
                  ),
                  Column(
                    children: [
                      Text("도시농부에 가입했던 이메일을 입력해주세요.",style: LrTheme.content,),
                      Text("비밀번호 재설정 메일을 보내드립니다.",style: LrTheme.content,),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
