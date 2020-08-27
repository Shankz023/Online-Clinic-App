import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        SizedBox(height: height*.1,),
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Container(
            width: width,
            height: height*.1,
            alignment: Alignment.center,
            transform: width<height?Matrix4.rotationZ(0.115):Matrix4.rotationZ(0.046),
            decoration: BoxDecoration(color: Colors.white70,borderRadius: BorderRadius.circular(20)),
            child: ShaderMask(shaderCallback: (bounds)=>LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.blue,
                  Colors.redAccent
                ]).createShader(bounds),
              child: Text('LOGIN HERE',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 36,shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black26,
                  offset: Offset(1, 3),
                ),
              ],
              ),
              ),),
          ),
        ),
        SizedBox(height: height*.1,),
        SingleChildScrollView(
          child: Container(
            height: height*0.6,
            width: width*0.97,
            padding: EdgeInsets.all(width*.04),
            decoration: BoxDecoration(gradient: LinearGradient(colors: <Color>[
              Colors.white38,
              Colors.white70,
              Colors.white24,
            ])),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height*.02,),
                RaisedButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed('/home_screen');
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,fontSize: 16),),
                  elevation: 10,color: Colors.deepPurpleAccent,),
                SizedBox(height: height*.02,),
                Container(
                  child: Text('OR',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                ),
                SizedBox(height: height*.02,),
                Row(
                  children: <Widget>[
                    SizedBox(width: width*.268,),
                    GestureDetector(
                      onTap: _submit,
                      child:
                      Icon(FontAwesomeIcons.google,size: height*.05,),
                    ),
                    SizedBox(width: width*.04,),
                    GestureDetector(
                      onTap: (){},
                      child:
                      Icon(FontAwesomeIcons.twitter,size: height*.055,),
                    ),
                    SizedBox(width: width*.04,),
                    GestureDetector(
                      onTap: _submitFb,
                      child:
                      Icon(FontAwesomeIcons.facebook,size: height*.05,),
                    ),
                  ],
                ),
                SizedBox(height: height*.1,),
                if(_isLoading)
                  CircularProgressIndicator()
                else
                  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('New User? '),
                    GestureDetector(
                      onTap: (){
                        print('signup');
                      },
                      child:
                      Text('Sign Up Here',style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w700),),
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

