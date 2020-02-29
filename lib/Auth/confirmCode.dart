import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/Auth/newPassword.dart';
import 'package:personal_safety/componants/card.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/models/confirm_mail.dart';
import 'package:personal_safety/models/confirm_token.dart';
import 'package:personal_safety/services/service_confirm.dart';
import 'package:personal_safety/services/service_confirmCode.dart';

class ConfirmCode extends StatefulWidget {
  @override
  _ConfirmCodeState createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _tokenController = TextEditingController();
  bool _isLoading = false;
  ConfirmTokenService get userService => GetIt.instance<ConfirmTokenService>();

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100, left: 30),
              child: Container(
                child: Text(
                  "Confirm Email",
                  style: TextStyle(fontSize: 30, color: primaryColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 145, left: 30),
              child: Container(
                child: Text(
                  "We've sent a verification code to your email ",
                  style: TextStyle(fontSize: 17, color: grey),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 195, left: 30),
                child: Text(
                  "Put the code then tap continue.",
                  style: TextStyle(fontSize: 17, color: Accent1),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 230, left: 20.0, right: 20.0),
              child: Container(
                decoration: kBoxDecorationStyle,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _tokenController,
                  keyboardType: TextInputType.text,
                  style: new TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(20),
                    hintText: "Code here",
                    errorBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 320, left: 70.0, bottom: 10, right: 70),
              child: Container(
                height: 50.0,
                width: 300,
                child: RaisedButton(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    setState(() async {
                      setState(() {
                        _isLoading = true;
                      });

                      final Token = ConfirmTokenCredentials(
                        token: _tokenController.text,
                      );
                      final result = await userService.confirmToken(Token);
                      debugPrint("from confirm: " + result.status.toString());
                      debugPrint("from confirm: " + result.result.toString());
                      debugPrint(
                          "from confirm: " + result.hasErrors.toString());
                      final title = result.status == 0 ? 'Confirmed!' : 'Error';
                      final text = result.status == 0
                          ? 'You will be forwarded to the next page!'
                          : "Wrong Email";
                      showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                                title: Text(title),
                                content: Text(text),
                                actions: <Widget>[
                                  FlatButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        Navigator.of(context).pop();
                                      })
                                ],
                              )).then((data) {
                        if (result.status == 0) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SuccessCard()));
                        }
                      });
                    });
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 350, left: 70.0, bottom: 10, right: 70),
              child: Container(
                child: SvgPicture.asset(
                  'assets/images/shield.svg',
                  color: grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
