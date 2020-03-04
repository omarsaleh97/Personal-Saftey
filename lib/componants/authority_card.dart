import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/componants/authority_data.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/componants/title_text.dart';
import 'package:personal_safety/models/authorityType.dart';

class AuthorityCard extends StatefulWidget {
  final Authority authority;
  AuthorityCard({Key key, this.authority}) : super(key: key);

  @override
  _AuthorityCardState createState() => _AuthorityCardState();
}

class _AuthorityCardState extends State<AuthorityCard> {
  Authority type;
  void initState() {
    type = widget.authority;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff006E90),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: EdgeInsets.symmetric(vertical: !type.isSelected ? 20 : 0),

      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),

      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 15),
              child: type.name),
          Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 15),
              child: type.description),
          Padding(
            padding: const EdgeInsets.only(top: 130, left: 13),
            child: Row(
              children: <Widget>[
                ButtonTheme(minWidth: 50, height: 25, child: type.button),
                SizedBox(
                  width: 130,
                ),
                Stack(
                  children: <Widget>[



                    type.image],
                )
              ],
            ),
          ),



        ],
      ),

    );
  }
}

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({Key key, this.diameter = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blue;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      pi / 2,
      pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
