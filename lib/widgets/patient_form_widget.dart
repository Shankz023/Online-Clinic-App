
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:intl/intl.dart';
import 'package:kuseswars_poly_clinic/model/book_model.dart';
import 'package:kuseswars_poly_clinic/screens/home_screen.dart';
import 'package:kuseswars_poly_clinic/screens/profile_screen.dart';
import 'package:kuseswars_poly_clinic/providers/database_handler.dart';
import 'package:kuseswars_poly_clinic/widgets/drawer_list.dart';
import 'package:kuseswars_poly_clinic/widgets/dropdown_list.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';


class PatientForm extends StatefulWidget {
  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {

  bool isNumeric(String val){
    int value;
    if(val==null)
      return false;
    else{
      try{
        value=int.parse(val);
        return true;
      }
      catch(e){
        return false;
      }
    }
  }
  final _formKey=GlobalKey<FormState>();
  final name= FocusNode();
  final _mobile= FocusNode();
  DateTime bookingDate;
  final age= FocusNode();
  String _selectedDate='Select Appointment Date';
  String textname;
  String textage;
  String sex="";
  String textmobile;
  DateTime appointmentDate;
  var male=0;
  var female=0;
  var others=0;
  void _selectedMale(int val){
    setState(() {
      male=1;
      female=0;
      others=0;
    });
  }
  void _selectedFemale(int val){
    setState(() {
      male=0;
      female=1;
      others=0;
    });
  }
  void _selectedOthers(int val){
    setState(() {
      male=0;
      female=0;
      others=1;
    });
  }

  Future<void> _selectDate(BuildContext ctx) async{
    final DateTime d=await showDatePicker(context: ctx, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime(2021));
    if (d != null)
      setState(() {
        _selectedDate = new DateFormat.yMMMMd("en_US").format(d);
        bookingDate=d;
      });
  }


  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;

    var width=MediaQuery.of(context).size.width;
    return Container(
      width: width*.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 40,
                  offset: Offset(.6, 1)
              ),
            ]
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(width*.03),
            height: height*.82,
            color: Colors.white,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Text('Patient Details',style: TextStyle(fontSize: 26,color: Colors.black,fontWeight: FontWeight.w700,letterSpacing: 1.2),),
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Patient Name',labelStyle: TextStyle(fontWeight: FontWeight.w600)),
                    onChanged: (value){
                      textname=value;
                    },
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(age);
                    },
                    validator: (value){
                      if(value.isEmpty)
                        return 'Enter Name';
                    },
                  ),
                  SizedBox(height: height*.01,),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: width*.02),
                    child: Text('Gender',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w600,letterSpacing: 1.2),),
                  ),
                  RadioListTile(
                      value: male,
                      activeColor: Colors.red,
                      title: Text('Male'),
                      groupValue: 1,
                      onChanged: (value){
                        _selectedMale(value);
                        sex='Male';
                      }),
                  RadioListTile(
                      value: female,
                      activeColor: Colors.red,
                      groupValue: 1,
                      title: Text('Female'),
                      onChanged: (value){
                        _selectedFemale(value);
                        sex='Female';
                      }),
                  RadioListTile(
                      value: others,
                      activeColor: Colors.red,
                      groupValue: 1,
                      title: Text('Others'),
                      onChanged: (value){
                        _selectedOthers(value);
                        sex='Others';
                      }),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Patient Age',labelStyle: TextStyle(fontWeight: FontWeight.w600),),
                    onChanged: (value){
                      textage=value;
                    },
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (_){
                      FocusScope.of(context).requestFocus(_mobile);
                    },
                    focusNode: age,
                    textInputAction: TextInputAction.next,
                    validator: (value){
                      if(value.isEmpty)
                        return 'Enter Age';
                      if(!isNumeric(value))
                        return 'Enter Number';
                    },
                  ),
                  TextFormField(
                    focusNode: _mobile,
                    decoration: InputDecoration(labelText: 'Mobile No',labelStyle: TextStyle(fontWeight: FontWeight.w600)),
                    onChanged: (value){
                      textmobile=value;
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validator: (value){
                      if(value.isEmpty)
                        return 'Enter Number';
                      if(value.length!=10)
                        return 'Enter 10 digit number';
                      if(!isNumeric(value))
                        return 'Enter Number';
                    },
                  ),
                  SizedBox(height: height*.02,),
                  Container(
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          child: Text(
                            _selectedDate,
                            textAlign: TextAlign.center,
                          ),
                          onTap: (){
                            _selectDate(context);
                          },
                        ),
                        IconButton(icon: Icon(FontAwesomeIcons.calendar), onPressed:(){
                          _selectDate(context);
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: height*.02,),
                  RaisedButton(
                    color: Colors.redAccent,
                    elevation: 20,
                    onPressed: (){

                      if(_formKey.currentState.validate()){
                        if(bookingDate==null||doctorsModel==null){
                          showDialog(context: context,barrierDismissible:true,
                              builder: (context)=>AlertDialog(
                                title: Text(bookingDate==null?'Select Date':'Select Doctor'),
                              elevation: 20,
                              actions: <Widget>[
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('OK',style: TextStyle(fontWeight: FontWeight.w600),),
                                  ),
                                  onTap: (){
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                              ),
                          );
                        }
                        else {
                          if(numb==null){
                            numb=mobile_number;
                            if(numb==null){
                              DataBaseHandler db=new DataBaseHandler();
                              db.readNumber(Email).then((onValue){
                                numb=onValue;
                              });
                              print(numb);
                            }
                          }
                          BookAppointment bk = new BookAppointment(
                              doctorsModel, textname, sex, textage, textmobile,_selectedDate,Name,Email,numb);
                          if(numb==null){
                            showDialog(context: context,
                            builder: (_)=>NetworkGiffyDialog(image: Image.network('https://media.tenor.com/images/c81eb65024ad8cc5a18893a594a1e99e/tenor.gif'),
                                title: Text('Register Number'),
                              buttonOkColor: Colors.redAccent,
                              buttonCancelColor: Colors.redAccent,
                              onOkButtonPressed: (){
                                Navigator.of(context).pushReplacementNamed('/profile_screen',arguments: {'name':Name,'image':ImageUrl,'email':Email,'number':numb});
                              },
                            )
                            );
                          }else {
                            DataBaseHandler db = new DataBaseHandler();
                            bool f = db.insertData(bk);
                            if (f == true) {
                              final snackbar = SnackBar(
                                content: Text('Appointment Booked'),
                                elevation: 20,
                                behavior: SnackBarBehavior.floating,
                                duration: Duration(seconds: 2),
                              );
                              
                              Scaffold.of(context).showSnackBar(snackbar);
                              Future.delayed(Duration(seconds: 2)).then((_){
                                Navigator.of(context).pop();
                              });
                            }
                          }
                        }
                      }
                    },
                    child: Text('Submit'),
                  )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
