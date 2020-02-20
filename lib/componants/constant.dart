import 'package:flutter/material.dart';
import 'package:personal_safety/componants/color.dart';



final kHintStyle =  TextStyle(
color: Colors.grey,

);

final kLabelStyle = TextStyle(
  color: Colors.grey,
  fontWeight: FontWeight.w400,
  fontFamily: 'OpenSans',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,

  borderRadius: BorderRadius.circular(15.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kBoxDecorationStyle2 = BoxDecoration(
  color: Colors.white,

  borderRadius: BorderRadius.circular(15.0),
);