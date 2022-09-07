import 'package:flutter/material.dart';

import '../themeData.dart';

class Loader extends StatelessWidget {
  final double opacity;
  final bool dismissibles;
  final Color color;
  final String loadingTxt;

  const Loader(
      {Key? key,
      this.opacity: 0.5,
      this.dismissibles: false,
      this.color: Colors.black,
      this.loadingTxt: 'Loading...'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: const ModalBarrier(dismissible: false, color: Colors.black),
        ),
        const Center(
          child: CircularProgressIndicator(
            color: MainColor.three,
          ),
        )
      ],
    );
  }
}
