import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/model/book_model.dart';
import 'package:kuseswars_poly_clinic/model/doctors_model.dart';
import 'package:kuseswars_poly_clinic/providers/database_handler.dart';
import 'package:kuseswars_poly_clinic/widgets/dropdown_list.dart';
import 'package:kuseswars_poly_clinic/widgets/patient_form_widget.dart';
class Booking extends StatefulWidget {
  List<DoctorsModel> doctors;
  Booking(this.doctors);
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {


  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('${widget.doctors[0].type}',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.w800),),
      ),
      body: ListView(
        children: <Widget>[
          Container(
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
                )
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height*.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownList(widget.doctors),
                  ],
                ),
                SizedBox(
                  height: height*.03,
                ),
                PatientForm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
