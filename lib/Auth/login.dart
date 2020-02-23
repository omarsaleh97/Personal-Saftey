import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personal_safety/Auth/forgetPassword.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/componants/mediaQuery.dart';
import 'package:personal_safety/models/login.dart';
import 'package:personal_safety/services/services.dart';
import 'package:get_it/get_it.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserService get userService => GetIt.instance<UserService>();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible;
  String errorMessages;
  LoginCredentials login;
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        resizeToAvoidBottomPadding: false,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height: displaySize(context).height * .4,
                width: displaySize(context).width * .8,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: SvgPicture.asset(
                  'assets/images/location.svg',
                  height: 250.0,
                  width: 50.0,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 85.0, left: 20.0, right: 20.0),
                    child: Container(
                      height: displaySize(context).height * .07,
                      decoration: kBoxDecorationStyle,
                      child: TextField(
                        style: new TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          hintText: "Email",
                          errorBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                        controller: _loginController,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 155.0, left: 20.0, right: 20.0),
                    child: Container(
                      height: displaySize(context).height * .07,
                      decoration: kBoxDecorationStyle,
                      child: TextField(
                        controller: _passwordController,
                        style: new TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          ),
                          errorBorder: InputBorder.none,
                          border: InputBorder.none,
                        ),
                        obscureText: passwordVisible,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment(.7, 0.0),
                    padding: EdgeInsets.only(top: 220, left: 20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetPassword()));
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                            color: Accent1,
                            fontFamily: 'Roboto',
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 70.0, bottom: 10, right: 70),
              child: Container(
                height: 50.0,
                width: 300,
                child: RaisedButton(
                  color: Accent1,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30),
                  ),
                  onPressed: () async {
                    final login = LoginCredentials(
                      email: _loginController.text,
                      password: _passwordController.text,
                    );
                    final result = await userService.Login(login);
                    final title = result.error ? 'Error Occured' : 'Logged In!';
                    final text = result.error
                        ? (result.errorMessages) ?? 'An Error Occured.'
                        : 'Bad Credentials';
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text(title),
                              content: Text(text),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                            )).then((data) {
                      if (result.result) {
                        Navigator.of(context).pop();
                      }
                    });
                  },
                  child: Center(
                    child: Text(
                      'Login',
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
          ]),
        ));
  }
}
