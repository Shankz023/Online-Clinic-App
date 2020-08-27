import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/providers/database_handler.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';
class UpcomingBookings extends StatefulWidget {
  @override
  _UpcomingBookingsState createState() => _UpcomingBookingsState();
}

class _UpcomingBookingsState extends State<UpcomingBookings> {
  var width,height;
  GlobalKey<AnimatedListState> _listkey=GlobalKey<AnimatedListState>();

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
                    Text('Patient\'s Name: '+futureList[index]['patient_name'].toString().toUpperCase(),style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Patient\'s Age: '+futureList[index]['age'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Booking Date: '+futureList[index]['booking_date'],style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Patient\'s Contact: '+futureList[index]['contact'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Patient\'s Sex: '+futureList[index]['sex'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                    Text('Appointed Doctor: '+futureList[index]['doctor_name'],style: TextStyle(color:  Colors.indigo,fontWeight: FontWeight.w400,letterSpacing: 1.0,),),
                  ],
                ),
                Positioned(child: InkWell(
                  child: Icon(Icons.clear),
                  onTap: (){
                    showDialog(context: ctx,barrierDismissible: false,builder: (_)=>AlertDialog(
                      elevation: 20,title: Text('Want to cancel booking?'),actions: <Widget>[
                      FlatButton(onPressed: (){
                        DataBaseHandler db=new DataBaseHandler();
                        var b=db.deleteEntry(Email,futureList[index]['booking_date'],index);
                        futureList.removeAt(index);
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
        child: futureList.length==0?Center(child: Text('No Data Present'),):AnimatedList(
          key: _listkey,
          initialItemCount: futureList.length,
          itemBuilder: _buildTodaylist,
        )
    );
  }
}
