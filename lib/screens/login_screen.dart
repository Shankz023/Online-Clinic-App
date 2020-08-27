import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_brand_icons/flutter_brand_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kuseswars_poly_clinic/screens/home_screen.dart';
import 'package:kuseswars_poly_clinic/widgets/form_widget.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TryAutoLogin auto=new TryAutoLogin();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
                  Colors.lightBlueAccent,
                  Colors.deepPurple,
                  Colors.pink[600],
                ]
            ),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
