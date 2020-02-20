import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:personal_safety/Auth/signupSuccessful.dart';
import 'package:personal_safety/componants/color.dart';

class SuccessCard extends StatefulWidget {
  @override
  _SuccessCardState createState() => _SuccessCardState();
}

class _SuccessCardState extends State<SuccessCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey2,
      body: Padding(
        padding: const EdgeInsets.only(top: 200, right: 50, left: 50),
        child: Container(
          width: 300,
          height: 500,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: primaryColor,
            elevation: 10,
            child: Stack(
              children: <Widget>[
                SvgPicture.asset(
                  'assets/images/night.svg',
                  height: 200,
                ),

         Padding(
           padding: const EdgeInsets.only(top:200,left: 20),
           child: Text("Congratulations",style: TextStyle(fontSize: 30,color: grey),),
         ),
                Padding(
                  padding: const EdgeInsets.only(top:240,left: 20),
                  child: Text("Before we continue using the full features of the app we need more information about you to make the procass of further helping you faster and more secure",style: TextStyle(fontSize: 15,color: grey),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 370,left:20),

                  child: Container(
                    height: 50.0,
                    width: 250,


                      child: RaisedButton(
                        color: Accent2,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30),
                        ),
                        onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpSuccessful()));
                        },
                        child: Center(
                          child: Text(
                            'Proceed',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
