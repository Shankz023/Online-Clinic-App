import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kuseswars_poly_clinic/model/doctors_model.dart';
import 'package:kuseswars_poly_clinic/model/speciality_model.dart';
DoctorsModel doctorsModel;
class DropdownList extends StatefulWidget {
  List<DoctorsModel> speciality;
  DropdownList(this.speciality);
  @override
  _DropdownListState createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  DoctorsModel selectedDoc;
 void _onSelected(DoctorsModel select){
   setState(() {
     selectedDoc=select;
     doctorsModel=selectedDoc;
   });
 }
  Speciality sp;

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    List<DoctorsModel> speciality=widget.speciality;
    return Container(
      color: Colors.white,
      child: DropdownButton<DoctorsModel>(
        hint: Text('Select Doctor'),
        elevation: 20,
        onChanged: (DoctorsModel value){
          _onSelected(value);
        },
        value: selectedDoc,
        icon: Icon(FontAwesomeIcons.angleDown),
        items: speciality.map((DoctorsModel doc){
          return DropdownMenuItem<DoctorsModel>(
            value: doc,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(width: width*.02,),
                Text(doc.name),
                Text('${doc.fees}',),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
