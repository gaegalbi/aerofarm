import 'package:flutter/material.dart';

/*
class RadioButton<T> extends StatelessWidget {
  final String description;
  final T value;
  final T groupValue;
  final void Function(T?)? onChanged;
  final Color? activeColor;
  final TextStyle? textStyle;
  final double contentPadding;

  const RadioButton(
      {Key? key,
        required this.description,
        required this.value,
        required this.groupValue,
        this.onChanged,
        this.activeColor,
        this.textStyle,
        required this.contentPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      child: Container(
        margin: EdgeInsets.only(
            top: contentPadding / 3, bottom: contentPadding / 3),
        padding: EdgeInsets.only(
          left: contentPadding,
          right: contentPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              description,
              style: textStyle,
              textAlign: TextAlign.left,
            ),
            Transform.scale(
              scale: 1.5,
              child: Radio<T>(
                groupValue: groupValue,
                onChanged: onChanged,
                value: value,
                activeColor: activeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
