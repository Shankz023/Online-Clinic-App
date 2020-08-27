
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kuseswars_poly_clinic/model/book_model.dart';
import 'package:kuseswars_poly_clinic/model/doctors_model.dart';
import 'package:kuseswars_poly_clinic/providers/database_handler.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';

DoctorsModel doctorsModel2;
var index;
class DoctorsTile extends StatefulWidget {

  @override
  _DoctorsTileState createState() => _DoctorsTileState();
  DoctorsTile(DoctorsModel d){
    doctorsModel2=d;
  }
}

class _DoctorsTileState extends State<DoctorsTile> {
  DateTime _dateTime;

  String s='not tap';
  bool f=false;
  String nam=Name;
  String email=Email;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white24
      ),
      child: ExpansionTile(
        title: Text('${doctorsModel2.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 1.2),),
        onExpansionChanged: (value){
        },
        children: <Widget>[
          Text(
            'Consultation charge is ${doctorsModel2.fees}',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,letterSpacing: 1.0),
          ),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}
