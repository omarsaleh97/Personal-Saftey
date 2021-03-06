import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:path/path.dart';
import 'package:personal_safety/componants/mediaQuery.dart';

final kHintStyle = TextStyle(
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

class CustomLoadingIndicator extends StatelessWidget {
  final Color customColor;
  const CustomLoadingIndicator({
    Key key,
    @required this.customColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: LoadingIndicator(
        color: customColor,
        indicatorType: Indicator.ballBeat,
      ),
    );
  }
}

final kBoxDecorationStyle2 = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(15.0),
);

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    TextInputType keyboard,
    TextStyle hintStyle,
    @required TextEditingController customController,
    @required String customHint,
  })  : customController = customController,
        customHint = customHint,
        keyboard = keyboard,
        hintStyle = hintStyle,
        super(key: key);

  final TextEditingController customController;
  final String customHint;
  final TextInputType keyboard;
  final TextStyle hintStyle;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboard,
      controller: customController,
      decoration: InputDecoration(
        errorBorder: InputBorder.none,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: const EdgeInsets.all(20),
//                        icon: Icon(
//                          Icons.contact_phone,
//                          color: grey,
//                        ),
        hintText: customHint,
        hintStyle:hintStyle,
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key key,
    @required this.context,
    @required TextEditingController fullNameController,
    @required bool validate,
  })  : _fullNameController = fullNameController,
        _validate = validate,
        super(key: key);

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
