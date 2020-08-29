import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kuseswars_poly_clinic/model/doctors_model.dart';
import 'package:kuseswars_poly_clinic/model/speciality_model.dart';
import 'package:kuseswars_poly_clinic/widgets/doctors_tile.dart';
import 'package:kuseswars_poly_clinic/widgets/dropdown_list.dart';
import 'package:kuseswars_poly_clinic/widgets/selectList.dart';
class SpecialityScreen extends StatefulWidget {
  Speciality speciality;
  SpecialityScreen(this.speciality);
  @override
  _SpecialityScreenState createState() => _SpecialityScreenState();
}

class _SpecialityScreenState extends State<SpecialityScreen> {
  List<String> a=[];
  String specialityName='';
  Widget _buildDoctors(BuildContext context,int index){

  }
  int getdocLength(String name){
    int count=0;
    for(int i=0;i<doctors.length;i++){
      if(name.compareTo(doctors[i].type)==0){
        specialityName=name;
        a.add(doctors[i].name);
        count++;
      }
      print(count);
    }
    return count;
  }



  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    //final Map speciality=ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                Colors.black54,
                Colors.white38,
                Colors.black54,
              ]
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Container(
                      child: Container(
                        height: height*.45,
                        width: width,
                        decoration: BoxDecoration(gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight ,
                            colors: <Color>[
                              Colors.teal[400],
                              Colors.tealAccent,
                            ]
                        ),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Hero(
                                tag: widget.speciality.id,
                                child: FadeInImage(placeholder: AssetImage(widget.speciality.imageUrl),fit: BoxFit.contain, image: AssetImage(widget.speciality.imageUrl))
                            ),
                            Positioned(
                              top: 10,
                              left: 5,
                              child: GestureDetector(
                                onTap: ()=>Navigator.of(context).pop(),
                                child: Icon(Icons.arrow_back_ios),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: height*.48,
                  child:Container(
                    height: height*.54,
                    width: width,
                    child:  SelectList(widget.speciality.name),
                  )
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width*.001,
                  top: MediaQuery.of(context).size.height*.046,
                  child: Container(
                    width: MediaQuery.of(context).size.width*.3,
                    child: FloatingActionButton(
                      backgroundColor: Colors.redAccent[200],
                      onPressed: (){
                        Navigator.of(context).pushNamed('/helper_bot_screen');
                      },
                      child: Icon(FontAwesomeIcons.question),
                      elevation: 10,

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
