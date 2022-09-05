import 'package:flutter/material.dart';
import '../themeData.dart';

class CustomIconTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  const CustomIconTextField({Key? key, required this.controller, required this.icon, required this.hintText}) : super(key: key);

  @override
  State<CustomIconTextField> createState() => _CustomIconTextFieldState();
}

class _CustomIconTextFieldState extends State<CustomIconTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MainSize.width * 0.696,
      margin: EdgeInsets.only(top: MainSize.height * 0.025),
      decoration: BoxDecoration(
          color: MainColor.one,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        controller: widget.controller,
          textInputAction: widget.hintText == "Username" ? TextInputAction.next : TextInputAction.done,
          obscureText: widget.hintText == "Password" ? true : false,
          obscuringCharacter: "*",
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(right: 15),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: Icon(
                widget.icon,
                size: 40,
                color: Colors.black,
              ),
              hintText: widget.hintText,
              hintStyle: LoginRegisterScreenTheme.hint,)
      ),
    );
  }
}
