import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';

class LoginPageTop extends StatelessWidget {
  const LoginPageTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.018),
          child: const Text(
            "도시농부",
            style: LoginRegisterPageTheme.title,
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.012),
          width: MediaQuery.of(context).size.width * 0.36,//MediaQuery.of(context).size.width * 0.3973,
          height: MediaQuery.of(context).size.height * 0.14, //MediaQuery.of(context).size.height * 0.1834,
          child: Image.asset(
            "assets/images/logo_blue.png",
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
