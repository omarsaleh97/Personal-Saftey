import 'package:flutter/material.dart';
import 'package:personal_safety/componants/mediaQuery.dart';



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


class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key key,
    @required this.context,
    @required TextEditingController fullNameController,
    @required bool validate,
  }) : _fullNameController = fullNameController, _validate = validate, super(key: key);

  final BuildContext context;
  final TextEditingController _fullNameController;
  final bool _validate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displaySize(context).height * .07,
      decoration: kBoxDecorationStyle,
      child: TextField(
        keyboardType: TextInputType.text,
        controller: _fullNameController,
        style: new TextStyle(color: Colors.black),
        decoration: InputDecoration(
          errorText: _validate ? 'Value Can\'t Be Empty' : null,
          contentPadding: const EdgeInsets.all(20),
          errorBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: "Full Name",
          hintStyle: kHintStyle,
        ),
      ),
    );
  }
}