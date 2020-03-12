import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Authority {
  int id;
  Text name;
  Text description;
  RaisedButton button;
 SvgPicture image;
 bool isSelected;

 Authority({
   this.image,this.button,this.name,this.description,this.id,this.isSelected=false
});
}