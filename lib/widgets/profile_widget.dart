import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:kuseswars_poly_clinic/screens/profile_screen.dart';
import 'package:kuseswars_poly_clinic/widgets/auth/mobile_auth.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

var visibility;
String mobile;
class ProfileWidget extends StatefulWidget {
  String userName, userImage, userEmail,userNumebr;
  ProfileWidget(this.userName,this.userImage,this.userEmail,this.userNumebr);
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final DBRef=FirebaseDatabase.instance.reference();
  @override
  void initState() {


    int lst=Email.lastIndexOf('.');
    
      DBRef.child('${Email.substring(0,lst)}').once().then((DataSnapshot datasnapShot) {
        if(datasnapShot.value!=null){
          if(datasnapShot.value['number']!=null){
            mobile_number= datasnapShot.value['number'];
          }
        }
      });
    

    // TODO: implement initState
    super.initState();
    this.initMyLibrary();
  }
  void initMyLibrary() {
    LicenseRegistry.reset();
    LicenseRegistry.addLicense(() async* {

      yield LicenseEntryWithLineBreaks(<String>['ACustomLibrary'], '''
  Copyright 2020 shankz.com. All rights reserved.
  
     * Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimer.
   
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS''');
    });
  }

  final _formKey=GlobalKey<FormState>();
  String number;
  String Number=numb;

  Widget _showBottomSheet(BuildContext context){
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    visibility=MediaQuery.of(context).viewInsets.bottom;
    return Container(
      height: visibility!=0?height*.5:height*.2,
      margin: EdgeInsets.only(top: height*.01,bottom: height*.01,left: width*.01,right: width*.01),
      padding: EdgeInsets.only(top: height*.01,bottom: height*.01,left: width*.02,right: width*.02),
      color: Colors.blue,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: (){
                },
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Mobile Number',
                ),
                onSaved: (value){
                  number=value;
                },
                keyboardType: TextInputType.number,
                validator: (value){
                  if(value.length!=10){
                    number=null;
                    return 'Enter valid mobile number';
                  }
                  if(value==null) {
                    number=null;
                    return 'It cannot be empty';
                  }
                },
              ),
            ),
            /**/

            SizedBox(height: height*.01,),
            RaisedButton(onPressed: ()async{
             SharedPreferences prefs=await SharedPreferences.getInstance();
             final extractedUserData=json.decode(prefs.getString('userData')) as Map<String,Object>;
              if(_formKey.currentState.validate()) {
                _formKey.currentState.save();
                MobileVerification mb=new MobileVerification(number,context);
                if(mb.registerNumber()==true) {
                  extractedUserData.addAll({'number':number});
                  final userData=json.encode(extractedUserData);
                  prefs.setString('userData', userData);
                  Navigator.of(context).pop();
                  setState(() {

                  });

                  print(number);
                }
              }

            },child: Text('Save'),),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: height*.14,
          width: width*.98,
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  height: height*.3,
                  padding: EdgeInsets.only(left: 10),
                  width: width*.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: height*.03,),
                      Text('Name: '+widget.userName,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white54)),
                      SizedBox(height: height*.01,),
                      Text(widget.userEmail,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white54),),
                      SizedBox(height: height*.01,),
                      GestureDetector(
                        child: Row(
                          children: <Widget>[
                            number!=null?Text('+91'+number,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white54),)
                                :mobile_number!=null?Text( mobile_number,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white54),)
                                :mobile!=null?Text(mobile,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color:Colors.white54),)
                                :Text('',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white54),),
                            SizedBox(width: width*.1,),
                            Icon(Icons.edit,size: 18,color: Colors.redAccent,),
                          ],
                        ),
                        onTap: (){
                          showModalBottomSheet(context: context, builder: (context)=>_showBottomSheet(context));
                          if(number!=null){
                            setState(() {
                            });
                          }
                        },
                      ),


                    ],
                  ),
                ),
                left: width*.01,
              ),
              Positioned(
                top: height*.02,
                right: width*.01,
                child: Container(
                    margin: EdgeInsets.only(left: width*.05),
                    child: CircleAvatar(child: CircleAvatar(backgroundImage: NetworkImage(widget.userImage),radius: 40,),radius: 43,backgroundColor: Colors.redAccent,)
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 2,),
        Container(
          margin: EdgeInsets.only(left: width*.02,top: height*.01),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Text('About',style: TextStyle(fontSize: 20,color: Colors.white70,fontWeight: FontWeight.w600),),
            SizedBox(height: height*.01,),
            GestureDetector(
              onTap: (){
                showAboutDialog(context: context,applicationName: 'Doctor Booking App',applicationVersion: '1.0.0',
                children: <Widget>[
                  Icon(FontAwesomeIcons.github),
                  SizedBox(height: height*.006,),
                  SelectableText(
                    'https://github.com/Shankz023/lecture0',style: TextStyle(fontSize: 14),cursorColor: Colors.redAccent,
                  ),
                ]
                );
              },
              child: Text('Version 1.0.0',style: TextStyle(fontSize: 14,color: Colors.white54,fontWeight: FontWeight.w400),),
            ),
              SizedBox(height: height*.01,),
            GestureDetector(
              onTap: (){
                showDialog(
                  context: context,builder: (_)=>NetworkGiffyDialog(
                    image: Image.network('https://media0.giphy.com/media/3o7TKGAJ7CLp95cNI4/giphy.gif'),
                    title: Text('Developer\'s Info',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),),
                  description: Text('Hola, It\'s me, Shankar Kumar Shaw, developer of this app.'
                      'Hope, You liked my work this is my full fleged work using Flutter'
                      ', It\'s an open source app you can get the code from my git-hub account, to get link click on Version.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400)),
                  entryAnimation: EntryAnimation.TOP,
                  buttonOkColor: Colors.redAccent,
                  onlyOkButton: true,
                  onOkButtonPressed: (){
                      Navigator.of(context).pop();
                  },
                ),
                );
              },
              child: Text('About Me',style: TextStyle(
                  fontSize: 14,color: Colors.white54,fontWeight: FontWeight.w400),),
            ),
          ],)
        ),
      ],
    );
  }
}
//