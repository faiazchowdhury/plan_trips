import 'package:flutter/material.dart';
import 'package:plan_trips/Constants/Style.dart';

import '../Constants/SizeConfig.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: SizeConfig.heightRatio * 100,
      width: SizeConfig.widthRatio * 100,
      child: Image.asset(
        "assets/bus.jpg",
        fit: BoxFit.fill,
        color: defaultColor,
        colorBlendMode: BlendMode.modulate,
      ),
    ));
  }
}
