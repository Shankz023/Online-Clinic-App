import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/animations/page_transition.dart';
import 'package:kuseswars_poly_clinic/model/speciality_model.dart';
import 'package:kuseswars_poly_clinic/screens/speciality_screen.dart';

var width,height;
class SpecialityCaarousel extends StatelessWidget {

  Widget _buildSpeciality(BuildContext context,int index){
    Speciality _speciality=specialities[index];
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(PageTransition(child: SpecialityScreen(_speciality), type: PageTransitionType.leftToRight),);
      },
      child: Container(

        child: Column(
          children: <Widget>[
            Container(
              height: height>width?200:height*.4,
              width: height>width?200:width*.2,
              margin: EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight ,
                    colors: <Color>[
                      Color(0xFF00C853),
                      Color(0xFFFFD740),
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
              child: ShaderMask(shaderCallback: (bounds)=>LinearGradient(
                begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                Colors.lightBlue,
                    Colors.lightBlueAccent
              ]).createShader(bounds),
                child: Text(_speciality.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.white),),),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Container(
      height: height>width?height*.44:height*.74,
      width: width*.97,
      child: CarouselSlider.builder(
        itemCount: specialities.length,
        itemBuilder: _buildSpeciality,
          options: CarouselOptions(
            height: height>width?height*.44:height*.74,
            viewportFraction: height>width?0.5:0.4,
            aspectRatio: 16/9,
            initialPage: 0,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
          ),
      ),
    );
  }
}
