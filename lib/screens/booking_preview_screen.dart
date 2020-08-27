import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kuseswars_poly_clinic/main.dart';
import 'package:kuseswars_poly_clinic/screens/today_booking_screen.dart';
import 'package:kuseswars_poly_clinic/screens/upcoming_booking_screen.dart';
import 'package:kuseswars_poly_clinic/screens/home_screen.dart';
import 'package:kuseswars_poly_clinic/providers/database_handler.dart';
import 'package:kuseswars_poly_clinic/widgets/drawer_list.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';

import 'old_bookings_screen.dart';
class BoolinfPreviewScreen extends StatefulWidget {
  @override
  _BoolinfPreviewScreenState createState() => _BoolinfPreviewScreenState();
}

class _BoolinfPreviewScreenState extends State<BoolinfPreviewScreen> with SingleTickerProviderStateMixin{
  static var _selectedIndex=0;
  static DataBaseHandler db=new DataBaseHandler();

  List _pages;
   TabController controller;
  void _selectIndex(int index){
    setState(() {
      _selectedIndex=index;
    });
  }
  @override
  void initState() {
    DataBaseHandler db=new DataBaseHandler();
    Future<bool>f1=db.getAllBookings(Email);
    controller=new TabController(
      vsync: this,
      initialIndex: 1,
      length: 3,
    );
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    home_book=false;
   // print(home_book);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
        bottom: new TabBar(
            controller: controller,
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.redAccent,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.history,size: 26,)),
              Tab(icon: Icon(Icons.today,size: 26)),
              Tab(icon: Icon(EvaIcons.navigation,size: 26)),
            ]),
      ),
      endDrawer: Drawer(
        elevation: 10,
        child: DrawerList('booking'),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          loadBook==true?Container(
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
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ): oldbookingList==null?Container(
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
              child: Center(
                child: Text('No Data Present'),
              )):OldBookings(),
          loadBooktoday==true?Container(
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
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ): fetchedList==null?Container(
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
              child: Center(
                child: Text('No Data Present'),
              )):TodaysBooking(),
          loadBookfuture==true?Container(
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
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ): futureList==null?Container(
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
              child: Center(
                child: Text('No Data Present'),
              )):UpcomingBookings(),
        ],
      ),
    );
  }
}
