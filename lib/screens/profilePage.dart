import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:personal_safety/Auth/logout.dart';
import 'package:personal_safety/componants/color.dart';
import 'package:personal_safety/componants/constant.dart';
import 'package:personal_safety/models/first_login.dart';
import 'package:personal_safety/screens/edit_profile.dart';
import 'package:personal_safety/services/get_profile_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirstLoginCredentials profileGetter;
  GetProfileService get profileService => GetIt.instance<GetProfileService>();
  Future getProfile() async {
    final result = await profileService.getProfile();
    setState(() {
      profileGetter = result.result;
    });
    print(profileGetter);
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: profileGetter == null
          ? Center(
              child: CustomLoadingIndicator(
              customColor: grey,
            ))
          : Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/ProfilePic.png')),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          border: Border.all(
                              width: 5,
                              color: greyIcon,
                              style: BorderStyle.solid)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
//              Badge(),
                    Padding(
                      padding: const EdgeInsets.only(left: 165.0),
                      child: Container(
                        width: 37,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                            color: Accent1),
                        child: Center(
                            child: Text(
                          "4.4",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                    Text(
                      profileGetter.fullName,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      height: 50.0,
                      width: 300,
                      child: RaisedButton(
                        color: Accent2,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile(
                                        profileGetter: profileGetter,
                                      )));
                        },
                        child: Center(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      child: Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        //_save("0");
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('token');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Logout()));
                      },
                    ),
                    SizedBox(height: 50),

                    SvgPicture.asset(
                      'assets/images/invoice.svg',
                      width: 150,
                      height: 200,
                      color: greyIcon,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
