import 'package:flutter/material.dart';

const accentColor = const Color(0XFFae1220); //#ae1220
const primaryColor = const Color(0XFFF9F9F9); //#F9F9F9
const textColor = const Color(0XFF64697C); //#64697C
const blackColor = const Color(0XFF000000); //#000000
const blackHeadingColor = const Color(0XFF444444); //#444444
const brownColor = const Color(0xff790d16);//#790d16

MaterialColor myColor = MaterialColor(0XFF81FFAD, color);

Map<int, Color> color = {
  50: Color.fromRGBO(129, 255, 173, .1),
  100: Color.fromRGBO(129, 255, 173, .2),
  200: Color.fromRGBO(129, 255, 173, .3),
  300: Color.fromRGBO(129, 255, 173, .4),
  400: Color.fromRGBO(129, 255, 173, .5),
  500: Color.fromRGBO(129, 255, 173, .6),
  600: Color.fromRGBO(129, 255, 173, .7),
  700: Color.fromRGBO(129, 255, 173, .8),
  800: Color.fromRGBO(129, 255, 173, .9),
  900: Color.fromRGBO(129, 255, 173, 1),
};

//add your styles here
const TextStyle medium20sp = TextStyle(fontSize: 20);
const TextStyle medium20spRed = TextStyle(fontSize: 20, color: accentColor);
const TextStyle medium18sp = TextStyle(fontSize: 18, color: Colors.grey);

const SizedBox smallSpace = SizedBox(height: 12, width: 12);
const SizedBox mediumSpace = SizedBox(height: 24, width: 24);
const SizedBox bigSpace = SizedBox(height: 40);

const TextStyle title24sp = TextStyle(fontSize: 24, color: blackHeadingColor, letterSpacing: -0.5,
            fontWeight: FontWeight.bold,);
const TextStyle title18sp = TextStyle(fontSize: 18, color: blackHeadingColor, letterSpacing: -0.5,
            fontWeight: FontWeight.bold,);            