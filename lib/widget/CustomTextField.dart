import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themeData.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  const CustomTextField({Key? key, required this.controller, required this.hintText}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
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
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(right: 15,left: 10),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: LoginRegisterScreenTheme.hint,)
      ),
    );
  }
}

class CustomRegisterTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  const CustomRegisterTextField({Key? key, required this.controller, required this.hintText, required this.title}) : super(key: key);

  @override
  State<CustomRegisterTextField> createState() => _CustomRegisterTextFieldState();
}

class _CustomRegisterTextFieldState extends State<CustomRegisterTextField> {
  @override
  Widget build(BuildContext context) {
    double margin = MainSize.height * 0.02;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: margin),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            widget.title,
            style: LoginRegisterScreenTheme.registerTitle,
            textAlign: TextAlign.start,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: margin),
          //alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextField(
            controller: widget.controller,
            textInputAction: TextInputAction.next,
            style: LoginRegisterScreenTheme.text,
            //textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                fillColor: MainColor.one,
                hintText: widget.hintText,
                hintStyle: LoginRegisterScreenTheme.hint),
          ),
        ),
      ],
    );
  }
}
