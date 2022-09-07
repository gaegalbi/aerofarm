import 'package:flutter/material.dart';

import '../themeData.dart';
import '../utils/PhoneNumberFormatter.dart';

class ProfileEditColumn extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool number;
  const ProfileEditColumn({Key? key, required this.controller, required this.text, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: MainScreenTheme.profileEditField,
        ),
        Container(
          decoration: BoxDecoration(
              color: MainColor.one,
              borderRadius: BorderRadius.circular(20)
          ),
          child: TextField(
            keyboardType: number ? TextInputType.number : TextInputType.text,
            inputFormatters: [
              if(number) PhoneNumberFormatter()
            ],
            controller: controller,
            decoration: custom(text),
          ),
        ),
      ],
    );
  }
}

InputDecoration custom(String text){
  return InputDecoration(
      contentPadding: const EdgeInsets.only(left: 10),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      hintText: text,
      hintStyle: LoginRegisterScreenTheme.hint);
}