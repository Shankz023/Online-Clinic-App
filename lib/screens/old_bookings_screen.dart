import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/providers/database_handler.dart';
class OldBookings extends StatefulWidget {
  @override
  _OldBookingsState createState() => _OldBookingsState();
}

class _OldBookingsState extends State<OldBookings> {
  GlobalKey<AnimatedListState> _listkey=GlobalKey<AnimatedListState>();
  var width,height;


  Widget _buildTodaylist(BuildContext ctx,int index,anim){
    return SlideTransition(position: Tween<Offset>(begin: Offset(1,0),end: Offset.zero).animate(anim),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white.withAlpha(210),borderRadius: BorderRadius.circular(10),boxShadow:[
              BoxShadow(color: Colors.black38,offset: Offset(.6, 1),blurRadius: 10)
            ] ),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Patient\'s Name: '+oldbookingList[index]['patient_name'].toString().toUpperCase(),style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Patient\'s Age: '+oldbookingList[index]['age'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Booking Date: '+oldbookingList[index]['booking_date'],style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Patient\'s Contact: '+oldbookingList[index]['contact'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Patient\'s Sex: '+oldbookingList[index]['sex'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Appointed Doctor: '+oldbookingList[index]['doctor_name'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                  ],
                ),

              ],
            )
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Container(
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
        width: width,
        height: height,
        child: AnimatedList(
          key: _listkey,
          initialItemCount: oldbookingList.length,
          itemBuilder: _buildTodaylist,
        )
    );
  }
}
