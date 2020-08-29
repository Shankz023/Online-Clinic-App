import 'dart:convert';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kuseswars_poly_clinic/main.dart';
import 'package:kuseswars_poly_clinic/providers/database_handler.dart';
import 'package:kuseswars_poly_clinic/widgets/form_widget.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';

String mobile;
bool home;
class DrawerList extends StatefulWidget {
  String s;
  DrawerList(this.s);

  @override
  _DrawerListState createState() => _DrawerListState();
}
String imageUrl;
class _DrawerListState extends State<DrawerList> {
  TryAutoLogin auto=new TryAutoLogin();
  FirebaseUser _user=user;
  bool _isloading=false;
  String image(){
    imageUrl=ImageUrl;
    print(ImageUrl);
    return imageUrl;
  }
  final DBRef=FirebaseDatabase.instance.reference();
  String mobile_number;

  Future late()async{
    return true;
  }

  int fst=Email.indexOf('.');
  int lst=Email.lastIndexOf('.');
  @override
  Widget build(BuildContext context) {
    home_book=home;
    return Container(
      decoration: BoxDecoration(color: Colors.grey[800]),
      child: ListView(
        children: <Widget>[
          ListTile(
            title: CircleAvatar(
              backgroundColor: Colors.redAccent,
              radius: 75,
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image(height: 145,width: 145,image: ((_user != null)?NetworkImage(_user.photoUrl):NetworkImage(ImageUrl)),fit: BoxFit.contain,),
                ),
              ),
            ),
          ),
          SizedBox( height: MediaQuery.of(context).size.height*.03,),
          ListTile(
            leading: Text('Home',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white70,fontFamily: 'GothamLight'),),
            onTap: (){
              if(widget.s.toString().compareTo('home')==0){
                Navigator.of(context).pop();
              }else{
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }

            },
            trailing: Icon(Icons.home,),
          ),
          Divider(height: MediaQuery.of(context).size.height*.03,thickness: 2,color: Colors.grey[500],),
          ListTile(
            leading: Text('Bookings',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white70,fontFamily: 'GothamLight'),),
            onTap: (){
              Navigator.of(context).pop();
              if(widget.s.toString().compareTo('home')==0){
                Navigator.of(context).pushNamed('/booking_preview_screen',);
              }
            },
            trailing: Icon(FontAwesomeIcons.bookMedical),
          ),
          Divider(height: MediaQuery.of(context).size.height*.03,thickness: 2,color: Colors.grey[500],),
          ListTile(
            leading: Text('Helper Bot',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white70,fontFamily: 'GothamLight'),),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed('/helper_bot_screen');
            },
            trailing: Icon(FontAwesomeIcons.robot),
          ),
          Divider(thickness: 2,color: Colors.grey[500],),
          if(_isloading)
            CircularProgressIndicator()
          else
            ListTile(
              leading: Text('Settings',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white70,fontFamily: 'GothamLight'),),
              onTap: (){
                if(Email!=null){
                    DBRef.child('${Email.substring(0,lst)}').once().then((DataSnapshot datasnapShot) {
                      if(datasnapShot.value!=null){
                        mobile_number= datasnapShot.value['number'];
                      }
                    });
                }
                bool val=true;
                if(val){
                  Navigator.of(context).pop();
                  (_user!=null) ?Navigator.of(context).pushNamed('/profile_screen',arguments: {'image':_user.photoUrl,'name':_user.displayName,'email':_user.email,'number':(mobile_number!=null?mobile_number:'')})
                      :Navigator.of(context).pushNamed('/profile_screen',arguments: {'image':ImageUrl,'name':Name,'email':Email,'number':'${mobile_number}'});
                }
              },
              trailing: Icon(Icons.settings),
            ),
            Divider(thickness: 2,color: Colors.grey[500],),
            ListTile(
              leading: Text('Log Out',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: Colors.white70,fontFamily: 'GothamLight'),),
              onTap: (){
                if(actualMode==Mode.google){
                  authGoogle.googleSignOut();
                  Navigator.of(context).pushReplacementNamed('/login_screen');
                }
                else{
                  authFacebook.SignOut();
                  Navigator.of(context).pushReplacementNamed('/login_screen');
                }
              },
              trailing: Icon(Icons.exit_to_app),
            ),
            Divider(thickness: 2,color: Colors.grey[500],),

        ],
      ),
    );
  }
}
