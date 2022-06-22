
import 'package:flutter/material.dart';

class TitleButton extends StatelessWidget {
  const TitleButton({Key? key, required this.title, required this.onPressed, required this.style}) : super(key: key);
  final String title;
  final Function onPressed;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.12,
      child: TextButton(
        onPressed: (){
          onPressed();
        },
        child: Text(title,style: style),
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero
        ),
      ),
    );
  }
}