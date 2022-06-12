
import 'package:flutter/material.dart';

import '../themeData.dart';

class TitleButton extends StatelessWidget {
  const TitleButton({Key? key, required this.title, required this.onPressed}) : super(key: key);
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.12,
      child: TextButton(
        onPressed: (){
          onPressed();
        },
        child: Text(title,style: CommunityPageTheme.titleButton,),
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero
        ),
      ),
    );
  }
}