import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FacebookAuth{
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  FacebookLogin facebookLogin=FacebookLogin();
  FirebaseUser user;
  Future signIn()async{
    final prefs=await SharedPreferences.getInstance();
    final result=await facebookLogin.logIn(['email']);
    final token=result.accessToken.token;
    final graphResponse=await http.get('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name&access_token=${token}');
    print(graphResponse.body);
    if(result.status==FacebookLoginStatus.loggedIn){
      final credential=FacebookAuthProvider.getCredential(accessToken: token);
      AuthResult result=await firebaseAuth.signInWithCredential(credential);
      user=result.user;
      Email=user.email;
      print(user.photoUrl);
      final userData=json.encode({'name':user.displayName,'image':user.photoUrl,'email':user.email});
      prefs.setString('userData', userData);
      return user;
    }
  }
  Future SignOut()async{
   final prefs =await SharedPreferences.getInstance();
    prefs.clear();
    print(prefs.getString('userData').toString()+' Shankz');

    await firebaseAuth.signOut().then((onValue) {
      facebookLogin.logOut();
    });
   return null;

  }

}