import 'dart:async';

import 'package:capstone/themeData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


final dateFormat = DateFormat('yyyy-MM-dd');
final timeFormat = DateFormat('hh:mm');
final koreanFormat = DateFormat('M월 d일');

class CurrentTime extends StatefulWidget {
  final bool type;
  final String style;

  const CurrentTime({Key? key,required this.type,required this.style}) : super(key: key);

  @override
  State<CurrentTime> createState() => _CurrentTimeState();
}

class _CurrentTimeState extends State<CurrentTime> {
  late Timer _timer;

  DateTime _currentTime = DateTime.now();
  String nowDate = dateFormat.format(DateTime.now());
  String nowTime = timeFormat.format(DateTime.now());
  String koreanTime = koreanFormat.format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), _onTimeChange);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onTimeChange(Timer timer) {
    setState(() {
      _currentTime = DateTime.now();
      nowDate = dateFormat.format(_currentTime);
      nowTime = timeFormat.format(_currentTime);
    });
  }

  @override
  Widget build(BuildContext context) {
   if(widget.style=="contentInfo") {
     if(widget.type) {
       return Text(nowDate,style: Community.contentInfo);
     } else {
       return Text(nowTime,style: Community.contentInfo);
     }
   } else if (widget.style=="sub"){
     if(widget.type) {
       return Text(nowDate,style: Community.sub);
     } else {
       return Text(nowTime,style:Community.sub);
     }
   }
   else if (widget.style=="korean") {
     if (widget.type) {
       return Text(koreanTime, style: Community.sub);
     } else {
       return Text(koreanTime, style: Community.sub);
     }
   }else{
     if(widget.type) {
       return Text(nowDate,style: null);
     } else {
       return Text(nowTime,style:null);
     }
   }
  }
}