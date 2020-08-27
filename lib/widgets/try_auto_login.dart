import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kuseswars_poly_clinic/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'form_widget.dart';


String ImageUrl;
String Name;
String Email;
String numb;
class TryAutoLogin with ChangeNotifier{
  bool f=false;
  SharedPreferences prefs;
  String name;

  bool get isAuth{
    if(ImageUrl!=null)
      return true;
    return false;
  }

  String check(){
    print(ImageUrl);
    return ImageUrl;
  }

  Future<bool> autologin()async{
    prefs=await SharedPreferences.getInstance();
    if(prefs.getString('userData')==null){
      //print('null');
      f=false;
      return false;
    }
    f=true;
    final extractedUserData=json.decode(prefs.getString('userData')) as Map<String,Object>;
    final userinfo=extractedUserData['image'];
    Name=extractedUserData['name'];
    ImageUrl=extractedUserData['image'];
    Email=extractedUserData['email'];
    if(extractedUserData.containsKey('number')){
      numb=extractedUserData['number'];
      print(numb);
    }
    notifyListeners();
    return true;
  }
  Future LogOut()async{
    prefs =await SharedPreferences.getInstance();
    prefs.clear();
    f=false;
    //print(prefs.getString('userData').toString()+' Shankz');
    return null;
  }
}