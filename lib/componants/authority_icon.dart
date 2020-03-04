import 'package:flutter/material.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/theme.dart';
import 'package:personal_safety/componants/title_text.dart';
import 'package:personal_safety/models/authorityType.dart';
class AuthorityIcon extends StatelessWidget {

  final Authority type;
  AuthorityIcon({Key key,this.type})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return type.id==null?Container(width: 5,):Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      padding: AppTheme.hPadding,
      alignment: Alignment.center,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: type.isSelected ? LightColor.background : Colors.transparent,
        border: Border.all(
            color: type.isSelected ? LightColor.orange : LightColor.grey,
            width: type.isSelected ? 2 : 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: type.isSelected ?  Color(0xfffbf2ef) : Colors.white,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(5,5)
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          type.image != null ? type.image : SizedBox(),
          type.name == null ? Container()
              : Container(
//            child: TitleText(
//              text: type.name,
//              fontWeight: FontWeight.w700,
//              fontSize: 15,
//            ),
          )
        ],
      ),
    );
  }
}