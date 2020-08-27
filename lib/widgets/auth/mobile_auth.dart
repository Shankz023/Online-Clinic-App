

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/model/book_model.dart';
import 'package:kuseswars_poly_clinic/screens/profile_screen.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';

BookAppointment bk;
class MobileVerification{
  String number;
  BuildContext context;
  MobileVerification(num,ctx){
    number='+91'+num;
    context=ctx;
  }
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  final _codeController=TextEditingController();

  Future<bool> registerNumber()async{
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: number,
        timeout: Duration(seconds: 120),
        verificationCompleted: (AuthCredential credential)async{
          try{
            AuthResult result=await firebaseAuth.signInWithCredential(credential);
            FirebaseUser user=result.user;
            if(user!=null){
              final DBRef=FirebaseDatabase.instance.reference();
              int fst=Email.indexOf('.');
              int lst=Email.lastIndexOf('.');
              if(fst!=lst){
                DBRef.child('${Email.substring(0,fst)}${Email.substring(fst+1,Email.lastIndexOf('.'))}${Email.substring(Email.lastIndexOf('.'),Email.length-1)}').update({'number':number});
              }
              else{
                DBRef.child('${Email.substring(0,Email.lastIndexOf('.'))}').update({'number':number});
              }
              mobile_number=number;
              Navigator.of(context).pop();
              return true;
            }
          }catch(e){
            return false;
          }
        },
        verificationFailed: (AuthException authException){
          print(authException.message+'jhhjjh');
        },
        codeSent: (String verficationId,[int forceResendingToken]){
          showDialog(context: context,
              barrierDismissible: false,
              builder: (context)=>AlertDialog(
            title: Text('Enter OTP code sent'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _codeController,
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(onPressed: ()async{
                final code=_codeController.text.trim();
                try{
                  AuthCredential credential=PhoneAuthProvider.getCredential(verificationId: verficationId, smsCode: code);
                  AuthResult result=await firebaseAuth.signInWithCredential(credential);
                  FirebaseUser user=result.user;
                  if(user!=null){
                    Navigator.of(context).pop();
                    return true;
                  }
                  else{
                    print('error else');
                    return false;
                  }
                }catch(e){
                  print(e.toString());
                  return false;
                }
              }, child: Text('Confirm'))
            ],
          ));
        },
        codeAutoRetrievalTimeout: null);
  }
}