import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/widgets/profile_widget.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';

import 'home_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
String mobile_number;
class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    final Map user=ModalRoute.of(context).settings.arguments as Map;
    String userName=user['name'];
    String userImage=user['image'];
    String userEmail=user['email'];
    String userNumber=user['number'];
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: Text('Settings',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'GothamMedium'),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              Colors.grey[850],
              Colors.grey[600],
              Colors.grey[850],
            ]
        ),
        ),
        child: ProfileWidget(userName,userImage,userEmail,userNumber),
      ),
    );
  }
}
