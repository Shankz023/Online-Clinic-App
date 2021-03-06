import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/animations/page_transition.dart';
import 'package:kuseswars_poly_clinic/model/speciality_model.dart';
import 'package:kuseswars_poly_clinic/screens/speciality_screen.dart';

class SpecialityGrid extends StatelessWidget {
  Widget _buildSpeciality(BuildContext context,int index){
   Speciality _speciality=specialities[index];
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(PageTransition(child: SpecialityScreen(_speciality), type: PageTransitionType.leftToRightWithFade));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height*.20,
              width: 200,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight ,
                    colors: <Color>[
                      Colors.teal[400],
                      Colors.tealAccent,
                    ]
                ),
              ),
              child: ClipRRect(
                child: Hero(tag: _speciality.id, child: Image(
                  image: AssetImage(
                      _speciality.imageUrl
                  ),
                  fit: BoxFit.contain,
                ),
                ),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(height: 10,),
            Container(
                 child: Text(_speciality.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'GothamLight'),),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speciality',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white,fontFamily: 'GothamMedium'),),
      ),
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: <Color>[
              Colors.black54,
              Colors.white38,
              Colors.black54,
            ]
        ),
        ),
        child: GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.height*.4,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
        ),
            itemBuilder: _buildSpeciality,
        itemCount: specialities.length,),
        padding: EdgeInsets.all(10),
      ),
    );
  }
}
