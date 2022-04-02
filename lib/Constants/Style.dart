import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plan_trips/Constants/SizeConfig.dart';

final defaultColor = Color.fromRGBO(117, 149, 188, 1);

final defaultHeading = TextStyle(
    height: 1.12,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: SizeConfig.heightRatio * 3.5);

final defaultHeadingPages = TextStyle(
    height: 1.12,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: SizeConfig.heightRatio * 3.3);

final cardHeading = TextStyle(
    height: 1.12,
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: SizeConfig.heightRatio * 2.5);

final hintTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: SizeConfig.heightRatio * 2.1,
    color: Color.fromRGBO(200, 200, 200, 1));

final hintTextStyleWithColor = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: SizeConfig.heightRatio * 2.1,
    color: defaultColor);
final defaultText = TextStyle(
    height: 1.12,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: SizeConfig.heightRatio * 1.8);

final logOutButtonTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: SizeConfig.heightRatio * 2.1,
    color: Colors.white);

final cardHintTextStyleWithColor = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: SizeConfig.heightRatio * 1.8,
    color: defaultColor);
final cardHintTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: SizeConfig.heightRatio * 1.8,
    color: Color.fromRGBO(200, 200, 200, 1));

final pageViewHeadingTextStyleWithColor = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: SizeConfig.heightRatio * 2,
    color: defaultColor);

final pageViewHeadingTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: SizeConfig.heightRatio * 2,
    color: Colors.black);

final pageViewDayTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: SizeConfig.heightRatio * 1.8,
    color: Colors.black);

final pageViewDayHintTextStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: SizeConfig.heightRatio * 1.8,
    color: Color.fromRGBO(150, 150, 150, 1));
