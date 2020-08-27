import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kuseswars_poly_clinic/model/user.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthGoogle {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser user;
  AuthCredential cred=null;

  Future handleSignIn() async {
    try {
      final prefs=await SharedPreferences.getInstance();
      if(!prefs.containsKey('userData')){
        GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
            .authentication;
        AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        AuthResult result = await _firebaseAuth.signInWithCredential(credential);
        user = result.user;
        Email=user.email;
        final userData=json.encode({'name':user.displayName,'image':user.photoUrl,'email':user.email});
        prefs.setString('userData', userData);
        return user;
      }
      else{

      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> googleSignOut() async {
    await _firebaseAuth.signOut().then((onValue) {
      _googleSignIn.signOut();
    });
    final prefs =await SharedPreferences.getInstance();
    prefs.clear();
    print(prefs.getString('userData').toString()+' Shankz');
    return null;
  }

}