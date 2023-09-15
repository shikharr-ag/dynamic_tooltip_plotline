import 'package:flutter/material.dart';

//TextStyles

const TextStyle headlineMedium = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w500,
  fontSize: 20,
  fontFamily: 'assets/Barlow/Barlow-Regular.ttf',
);

const TextStyle bodySmall = TextStyle(
  color: Color.fromRGBO(0, 0, 0, 0.25),
  fontSize: 16,
  height: 0.89,
  fontWeight: FontWeight.w400,
  fontFamily: 'assets/Barlow/Barlow-Regular.ttf',
);

const TextStyle bodyMedium = TextStyle(
  color: Color.fromRGBO(0, 0, 0, 0.88),
  fontWeight: FontWeight.w400,
  fontSize: 16,
  height: 0.89,
  fontFamily: 'assets/Barlow/Barlow-Regular.ttf',
);

BorderRadius myRad = BorderRadius.circular(6.0);

//Colors

const Color backgroundColor = Color.fromRGBO(245, 245, 245, 1);
const Color backgroundColorTwo = Color.fromRGBO(134, 134, 134, 1);
const Color borderColor = Color.fromRGBO(0, 0, 0, 0.15);

//Border Style
InputBorder myBorder = OutlineInputBorder(
  borderSide: BorderSide(color: borderColor),
  borderRadius: BorderRadius.circular(6.0),
);

//Size Factors
const num horizontalPaddingFactor = 0.08;
