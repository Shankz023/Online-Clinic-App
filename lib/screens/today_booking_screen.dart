import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/providers/database_handler.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';

class TodaysBooking extends StatefulWidget {
  @override
  _TodaysBookingState createState() => _TodaysBookingState();
}

class _TodaysBookingState extends State<TodaysBooking> {

  GlobalKey<AnimatedListState> _listkey=GlobalKey<AnimatedListState>();
  List<Map<dynamic,dynamic>> lst=<Map<dynamic,dynamic>>[];
  bool _isloading=false;
  var width, height;
  List<Map<dynamic,dynamic>> mo=<Map<dynamic,dynamic>>[];
  List<Map<dynamic,dynamic>> getName(){
    if(fetchedList != null){

      fetchedList.forEach((f){
        //print(f.runtimeType.toString()+' '+f.toString());
        Map<dynamic,dynamic>hashMap=f;
        //print(hashMap.toString());
        if(hashMap!=null)
        {
          hashMap.forEach((val,key){
          });
          if(!_isloading){
            mo.add(hashMap);
          }
        }
      });
    }
    _isloading=true;
    return mo;
  }

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
                    Text('Patient\'s Name: '+lst[index]['patient_name'].toString().toUpperCase(),style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Patient\'s Age: '+lst[index]['age'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Booking Date: '+lst[index]['booking_date'],style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Patient\'s Contact: '+lst[index]['contact'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Patient\'s Sex: '+lst[index]['sex'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Appointed Doctor: '+lst[index]['doctor_name'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                  ],
                ),
                Positioned(child: InkWell(
                  child: Icon(Icons.clear),
                  onTap: (){
                    showDialog(context: ctx,barrierDismissible: false,builder: (_)=>AlertDialog(
                      elevation: 20,title: Text('Want to cancel booking?'),actions: <Widget>[
                      FlatButton(onPressed: (){
                        DataBaseHandler db=new DataBaseHandler();
                        var b=db.deleteEntry(Email,lst[index]['booking_date'],index+1);
                        fetchedList.removeAt(index+1);
                        lst.removeAt(index);
                        setState(() {
                          Future<List<dynamic>>f=db.getTodaysAppointment(Email);
                        });
                        _listkey.currentState.removeItem(index,(ctx, animation){
                          return SizeTransition(sizeFactor: animation,axis: Axis.vertical,
                          child: Container(),
                          );
                        });
                        setState(() {
                        });
                        Navigator.of(context).pop();
                        }, child: Text('OK')),
                      FlatButton(
                        onPressed: (){
                          Navigator.of(ctx).pop();
                        }, child:
                      Container(
                        alignment: Alignment.center,
                        height: height*.05,
                        width: width*.2,
                        child: Text('Cancel'),
                      ),
                      ),
                    ],
                    )
                    );
                  },
                ),
                  right: 30,
                  top: height*.04,
                )
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
    lst=getName();
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
                  Colors.black54,
                  Colors.white54,
                  Colors.black54,
                ]
            ),
        ),
        width: width,
        height: height,
        child: lst==null?Center(child: Text('No Data Present'),):
        AnimatedList(
          key: _listkey,
          initialItemCount: lst.length,
          itemBuilder: _buildTodaylist,
        )
    );
  }
}

