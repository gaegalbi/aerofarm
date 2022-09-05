import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text.length>13){
      return TextEditingValue(
        text: newValue.text.substring(0,newValue.text.length-1),
        selection: TextSelection.collapsed(
            offset: (newValue.text).length-1),
      );
    }else{
      if(newValue.text.length < oldValue.text.length){
        if(oldValue.text[oldValue.text.length-1] == "-"){
          return TextEditingValue(
            text: newValue.text.substring(0,newValue.text.length-1),
            selection: TextSelection.collapsed(
                offset: (newValue.text).length-1),
          );
        }else{
          return TextEditingValue(
            text: newValue.text,
            selection: TextSelection.collapsed(
                offset: (newValue.text).length),
          );
        }
      }else {
        if (oldValue.text.length == 2 || oldValue.text.length == 7) {
          return TextEditingValue(
            text: newValue.text + "-",
            selection: TextSelection.collapsed(
                offset: (newValue.text + "-").length),
          );
        }
        else {
          return newValue;
        }
      }
    }
  }
}