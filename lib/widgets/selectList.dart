import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/animations/page_transition.dart';
import 'package:kuseswars_poly_clinic/model/book_model.dart';
import 'package:kuseswars_poly_clinic/model/doctors_model.dart';
import 'package:kuseswars_poly_clinic/screens/booking_screen.dart';
import 'package:kuseswars_poly_clinic/widgets/doctors_tile.dart';
class SelectList extends StatelessWidget {
  String name;
  SelectList(this.name);

  Widget _buildskin(BuildContext ctx,int index){
    return DoctorsTile(skin[index]);
  }
  Widget _buildOrtho(BuildContext ctx,int index){
    return DoctorsTile(ortho[index]);
  }
  Widget _buildGas(BuildContext ctx,int index){
   return DoctorsTile(gas[index]);
  }
  Widget _buildChild(BuildContext ctx,int index){
   return DoctorsTile(child[index]);
  }
  Widget _buildDiabetes(BuildContext ctx,int index){
   return DoctorsTile(diabetes[index]);
  }
  Widget _buildGeneral(BuildContext ctx,int index){
   return DoctorsTile(general_doctors[index]);
  }
  Widget _buildNerve(BuildContext ctx,int index){
   return DoctorsTile(nerve[index]);
  }
  Widget _buildThyroid(BuildContext ctx,int index){
   return DoctorsTile(thyroid[index]);
  }
  Widget _buildDental(BuildContext ctx,int index){
   return DoctorsTile(dental[index]);
  }
  Widget _buildGyno(BuildContext ctx,int index){
   return DoctorsTile(gyno[index]);
  }

  Widget _getAppointment(List<DoctorsModel> doc){

  }

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    if(name.compareTo(skin[0].type)==0){
      return Container(
        height: height*.54,
        width: width,
        child: Stack(
          children: <Widget>[
            Container(
              child: ListView.builder(
                itemBuilder: _buildskin,
                itemCount: skin.length,
              ),
            ),
            Positioned(
              bottom: height*.02,
                left: width*.32,
                child: RaisedButton(
                  onPressed: (){
                    print(skin[0].type);
                    Navigator.of(context).push(PageTransition(child: Booking(skin), type: PageTransitionType.leftToRightWithFade));
                    },
                  color: Colors.redAccent,
                  child: Text('Book Appointment'),
                ),
            ),
          ],
        )
      );
    }
    if(name.compareTo(ortho[0].type)==0){
      return Container(
          height: height*.54,
          child: Stack(
            children: <Widget>[
              Container(
                height: height*.4,
                child: ListView.builder(
                  itemBuilder: _buildOrtho,
                  itemCount: ortho.length,
                ),
              ),
              Positioned(
                bottom: height*.02,
                left: width*.32,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: Booking(ortho), type: PageTransitionType.leftToRightWithFade));
                  },
                  color: Colors.redAccent,
                  child: Text('Book Appointment'),
                ),
              ),
            ],
          )
      );
    }

    if(name.compareTo(dental[0].type)==0){
      return Container(
          height: height*.54,
          child: Stack(
            children: <Widget>[
              Container(
                height: height*.4,
                child: ListView.builder(
                  itemBuilder: _buildDental,
                  itemCount: dental.length,
                ),
              ),
              Positioned(
                bottom: height*.02,
                left: width*.32,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: Booking(dental), type: PageTransitionType.fade));
                    },
                  color: Colors.redAccent,
                  child: Text('Book Appointment'),
                ),
              ),
            ],
          )
      );
    }

    if(name.compareTo(gas[0].type)==0){
      return Container(
          height: height*.54,
          child: Stack(
            children: <Widget>[
              Container(
                height: height*.4,
                child: ListView.builder(
                  itemBuilder: _buildGas,
                  itemCount: gas.length,
                ),
              ),
              Positioned(
                bottom: height*.02,
                left: width*.32,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: Booking(gas), type: PageTransitionType.fade));
                    },
                  color: Colors.redAccent,
                  child: Text('Book Appointment'),
                ),
              ),
            ],
          )
      );
    }

    if(name.compareTo(nerve[0].type)==0){
      return Container(
          height: height*.54,
          child: Stack(
            children: <Widget>[
              Container(
                height: height*.4,
                child: ListView.builder(
                  itemBuilder: _buildNerve,
                  itemCount: nerve.length,
                ),
              ),
              Positioned(
                bottom: height*.02,
                left: width*.32,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: Booking(nerve), type: PageTransitionType.fade));
                    },
                  color: Colors.redAccent,
                  child: Text('Book Appointment'),
                ),
              ),
            ],
          )
      );
    }

    if(name.compareTo(gyno[0].type)==0){
      return Container(
          height: height*.54,
          child: Stack(
            children: <Widget>[
              Container(
                height: height*.4,
                child: ListView.builder(
                  itemBuilder: _buildGyno,
                  itemCount: gyno.length,
                ),
              ),
              Positioned(
                bottom: height*.02,
                left: width*.32,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: Booking(gyno), type: PageTransitionType.fade));
                    },
                  color: Colors.redAccent,
                  child: Text('Book Appointment'),
                ),
              ),
            ],
          )
      );
    }

    if(name.compareTo(general_doctors[0].type)==0){
      return Container(
          height: height*.54,
          child: Stack(
            children: <Widget>[
              Container(
                height: height*.45,
                child: ListView.builder(
                  itemBuilder: _buildGeneral,
                  itemCount: general_doctors.length,
                ),
              ),
              Positioned(
                bottom: height*.02,
                left: width*.32,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: Booking(general_doctors), type: PageTransitionType.fade));
                    },
                  color: Colors.redAccent,
                  child: Text('Book Appointment'),
                ),
              ),
            ],
          )
      );
    }

    if(name.compareTo(child[0].type)==0){
      return Container(
          height: height*.54,
          child: Stack(
            children: <Widget>[
              Container(
                height: height*.4,
                child: ListView.builder(
                  itemBuilder: _buildChild,
                  itemCount: child.length,
                ),
              ),
              Positioned(
                bottom: height*.02,
                left: width*.32,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: Booking(child), type: PageTransitionType.fade));
                    },
                  color: Colors.redAccent,
                  child: Text('Book Appointment'),
                ),
              ),
            ],
          )
      );
    }

    if(name.compareTo(thyroid[0].type)==0){
      return Container(
          height: height*.54,
          child: Stack(
            children: <Widget>[
              Container(
                height: height*.4,
                child: ListView.builder(
                  itemBuilder: _buildThyroid,
                  itemCount: thyroid.length,
                ),
              ),
              Positioned(
                bottom: height*.02,
                left: width*.32,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.of(context).push(PageTransition(child: Booking(thyroid), type: PageTransitionType.fade));
                  },
                  color: Colors.redAccent,
                  child: Text('Book Appointment'),
                ),
              ),
            ],
          )
      );
    }
    return Container(
        height: height*.54,
        child: Stack(
          children: <Widget>[
            Container(
              height: height*.4,
              child: ListView.builder(
                itemBuilder: _buildDiabetes,
                itemCount: diabetes.length,
              ),
            ),
            Positioned(
              bottom: height*.02,
              left: width*.32,
              child: RaisedButton(
                onPressed: (){
                  Navigator.of(context).push(PageTransition(child: Booking(diabetes), type: PageTransitionType.fade));
                  },
                color: Colors.redAccent,
                child: Text('Book Appointment'),
              ),
            ),
          ],
        )
    );
    }
  }
