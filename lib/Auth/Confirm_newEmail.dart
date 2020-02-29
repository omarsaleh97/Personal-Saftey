import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/Auth/confirmCode.dart';
import 'package:personal_safety/Auth/login.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/mediaQuery.dart';
import 'package:personal_safety/models/confirm_mail.dart';
import 'package:personal_safety/services/service_confirm.dart';

class ConfirmEmail extends StatefulWidget {
  @override
  _ConfirmEmailState createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  ConfirmService get userService => GetIt.instance<ConfirmService>();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  TextEditingController _loginController = TextEditingController();

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 30),
            child: Container(
              child: Text(
                "Confirm your Email",
                style: TextStyle(fontSize: 30, color: primaryColor),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 145, left: 30),
            child: Container(
              child: Text(
                "Enter your email that you signed up with",
                style: TextStyle(fontSize: 17, color: grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 165, left: 30),
            child: Container(
              child: Text(
                "then tap verify",
                style: TextStyle(fontSize: 17, color: Accent1),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 195),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: displaySize(context).height * .07,
                      decoration: kBoxDecorationStyle2,
                      child: TextField(
                        controller: _loginController,
                        style: new TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          errorBorder: InputBorder.none,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          contentPadding: const EdgeInsets.all(20),
                          hintText: "Email",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 280, left: 70.0, bottom: 10, right: 70),
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

                    final confirm = ConfirmMailCredentials(
                      email: _loginController.text,
                    );
                    final result = await userService.confirmMail(confirm);
                    debugPrint("from confirm: " + result.status.toString());
                    debugPrint("from confirm: " + result.result.toString());
                    debugPrint("from confirm: " + result.hasErrors.toString());
                    final title =
                        result.status == 0 ? 'Sending successfuly!' : 'Error';
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
                                builder: (context) => Login()));
                      }
                    });
                  });
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Center(
                  child: Text(
                    'Verify',
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
    );
  }
}
