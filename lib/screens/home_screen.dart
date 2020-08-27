import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/main.dart';
import 'package:kuseswars_poly_clinic/model/user.dart';
import 'package:kuseswars_poly_clinic/screens/profile_screen.dart';
import 'package:kuseswars_poly_clinic/providers/database_handler.dart';
import 'package:kuseswars_poly_clinic/widgets/drawer_list.dart';
import 'package:kuseswars_poly_clinic/widgets/form_widget.dart';
import 'package:kuseswars_poly_clinic/widgets/speciality_carousel.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';

String mobile;
bool loadBook=true;
bool loadBooktoday=true;
bool loadBookfuture=true;
class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final DBRef=FirebaseDatabase.instance.reference();
  @override
  void initState() {
    DataBaseHandler db=new DataBaseHandler();
    home_book=true;
    Future<bool>f1=db.getAllBookings(Email);
    Future<List<dynamic>>f=db.getTodaysAppointment(Email);
    if(Email!=null){
      int lst=Email.lastIndexOf('.');
        DBRef.child('${Email.substring(0,lst)}').once().then((DataSnapshot datasnapShot) {
          if(datasnapShot.value!=null)
            mobile_number= datasnapShot.value['number'];
        });
      }

      TryAutoLogin _auto=TryAutoLogin();
      // TODO: implement initState
      super.initState();
  }
        @override
        Widget build(BuildContext context) {

      TryAutoLogin _auto=TryAutoLogin();
      var height=MediaQuery.of(context).size.height;
      var width=MediaQuery.of(context).size.width;
      return Scaffold(
        endDrawer: Drawer(
          child: DrawerList('home'),
        ),
        body: Container(
          decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                Colors.lightBlueAccent,
                Colors.deepPurple,
                Colors.pink[600],
              ]
          )
          ),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 340,
                pinned: true,
                elevation: 20,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text('Kuseshwar\'s PolyClinic',style: TextStyle(fontSize: 16,letterSpacing: 1),textAlign: TextAlign.left,),
                  background: Container(
                    decoration: BoxDecoration(color: Colors.black54),
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: height*.045,),
                        Image(
                          image: AssetImage('assets/images/Logo.png'),
                          height: 300,
                          fit: BoxFit.fitHeight,
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                ],
              ),
              SliverFillRemaining(
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: width*.05),
                              width: width*.34,
                              alignment: Alignment.topLeft,
                              child: Text('SPECIALITY',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.indigoAccent),textAlign: TextAlign.start,),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pushNamed('/speciality_grid_screen');
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: ((width*.8)-(width*.05)-(width*.34))),
                                child: Text('SEE ALL',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w800,color: Colors.red[600])),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        SpecialityCaarousel(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

