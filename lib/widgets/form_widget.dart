import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/widgets/auth/facebook_auth.dart';
import 'package:kuseswars_poly_clinic/widgets/auth/google_auth.dart';
FirebaseUser user;
enum Mode{
  google,
  facebook,
  twitter
}
var actualMode;
class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

final AuthGoogle authGoogle=AuthGoogle();
final FacebookAuth authFacebook=FacebookAuth();

class _LoginFormState extends State<LoginForm> {
  bool _isLoading=false;
  final _formkey=GlobalKey<FormState>();
  Future<void> _submit()async{
    actualMode=Mode.google;
    setState(() {
      _isLoading=true;
    });
    user=await authGoogle.handleSignIn();
    if(user!=null){
      Navigator.of(context).pushReplacementNamed('/home_screen',arguments: {'user':user});
    }
    setState(() {
      _isLoading=false;
    });
  }

  Future<void> _submitFb() async{
    actualMode=Mode.facebook;
    setState(() {
      _isLoading=true;
    });
    user=await authFacebook.signIn();

    if(user!=null){
      Navigator.of(context).pushReplacementNamed('/home_screen',arguments: {'user':user});
    }
    setState(() {
      _isLoading=false;
    });


  }

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: height>width?height*.25:0,),
        Container(
          child: Container(
            width: width,
            height: height>width?height*.1:width*.1,
            alignment: Alignment.center,
            child: Text('K. P. Clinic',style: TextStyle(fontWeight: FontWeight.w900,wordSpacing: 5,fontFamily: 'BigLake',fontSize: 50,shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black26,
                  offset: Offset(1, 3),
                ),
              ],
                color: Colors.redAccent.withAlpha(240)
              ),
              ),
          ),
        ),
        SizedBox(height: height>width?height*.2:width*.04,),
        SingleChildScrollView(
          child: Container(
            width: width*0.97,
            padding: EdgeInsets.all(width*.04),
            child: Column(
              children: <Widget>[
                SizedBox(height: height*.02,),
                if(_isLoading)
                  CircularProgressIndicator()
                else
                Column(
                  children: <Widget>[
                    SizedBox(height: height*.03,),
                    GestureDetector(
                      onTap: _submit,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Container(
                          width: width,
                          height: height>width?height*.07:height*.1,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 40,
                              offset: Offset(.6, 1),
                            ),
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 40,
                              offset: Offset(4, 1),
                            ),
                          ],
                            color: Colors.white,
                          ),
                          child: Image.asset('assets/images/google.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: height*.03,),
                    GestureDetector(
                      onTap: (){},
                      child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Container(
                          width: width,
                          height: height>width?height*.07:height*.1,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 40,
                              offset: Offset(.6, 1),
                            ),
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 40,
                              offset: Offset(4, 1),
                            ),
                          ],
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text('twitter',style: TextStyle(fontFamily: 'Indigo',color: Colors.blue,fontSize: 26),),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height*.03,),
                    GestureDetector(
                      onTap: _submitFb,
                      child:
                      ClipRRect(
                        borderRadius: BorderRadius.circular(35),
                        child: Container(
                          width: width,
                          height: height>width?height*.07:height*.1,
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 40,
                              offset: Offset(.6, 1),
                            ),
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 40,
                              offset: Offset(4, 1),
                            ),
                          ],
                            color: Colors.white,
                          ),
                          child: Image(image: AssetImage('assets/images/facebook.png'),fit: BoxFit.fitHeight),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

