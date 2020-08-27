import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:kuseswars_poly_clinic/main.dart';
import 'package:kuseswars_poly_clinic/model/book_model.dart';
import 'package:kuseswars_poly_clinic/screens/home_screen.dart';

dynamic fetchedData;
List<dynamic> fetchedList;
List<dynamic> oldbookingList;
List<dynamic> futureList;
Map<dynamic,Map<dynamic,dynamic>> oldData;
List<dynamic> dats;
class DataBaseHandler{
  String codedEmail(String mail){
    String w="";
    for(int i=0;i<mail.lastIndexOf('.');i++){
      if(mail.substring(i,i+1).compareTo('.')!=0){
        w=w+mail.substring(i,i+1);
      }
    }
    return w;
  }
  final DBRef=FirebaseDatabase.instance.reference();
  var i=0;
  bool insertData(BookAppointment bookAppointment){
    bool f;
    try {
      String s = codedEmail(bookAppointment.userMail);
      DBRef.child(s).child(bookAppointment.date).child('patientinfo').once().then((DataSnapshot snapshot){
        if(snapshot.value!=null){
          List<dynamic>value=snapshot.value;
          value.forEach((value){
              print(value.toString());
            i+=1;
          });
          DBRef.child(s).child( bookAppointment.date).child('patientinfo').child(
              '$i').set({
            'patient_name': bookAppointment.name,
            'booking_date': bookAppointment.date,
            'sex': bookAppointment.sex,
            'age': bookAppointment.age,
            'contact': bookAppointment.number,
            'doctor_name': bookAppointment.doc.name,
            'fees': bookAppointment.doc.fees,
            'doctor_id': bookAppointment.doc.id,
          });
        }
        else{
          DBRef.child(s).child( bookAppointment.date).child('patientinfo').child(
              '${i+1}').set({
            'patient_name': bookAppointment.name,
            'booking_date': bookAppointment.date,
            'sex': bookAppointment.sex,
            'age': bookAppointment.age,
            'contact': bookAppointment.number,
            'doctor_name': bookAppointment.doc.name,
            'fees': bookAppointment.doc.fees,
            'doctor_id': bookAppointment.doc.id,
          });
        }
      });

      return true;
    }catch(e){
      return false;
    }
  }
  String number;
 String get Number{
    return number;
}
  Future<String> readNumber(String email)async{
   String s=codedEmail(email);
   String num;
   try{
     DBRef.child(s).once().then((DataSnapshot snapshot){
       if(snapshot!=null)
         num=snapshot.value['number'];
       print(snapshot.value['number'].toString());
       return num;
     });
   }catch(e){
     return null;
   }
  }

  Future<List> getTodaysAppointment(String email)async{
   String s=codedEmail(email);
   DateTime dt=DateTime.now();
   String today=new DateFormat.yMMMMd('en_US').format(dt);
   try{
     bookLoading=true;
     loadBooktoday=false;
     DBRef.child(s).child(today).child('patientinfo').once().then((DataSnapshot snapshot){
       if(snapshot!=null){
         List<dynamic> lt=snapshot.value;
         //print(lt.length);
         //print(lt.toString());
        if(lt!=null){
          fetchedList=lt.toList();
          return lt.toList();
        }
         loadBooktoday=false;
       }
       return false;
     });
   }catch(e){
     print('Error');
   }
  }


  Future<bool> getAllBookings(String email)async{
   DateTime val;
   oldbookingList=new List<dynamic>();
   futureList=new List<dynamic>();
   String today=new DateFormat.yMMMMd('en_US').format(DateTime.now());
    String s=codedEmail(email);
    try{
      bookLoading=true;
      DBRef.child(s).once().then((DataSnapshot snapshot){
        if(snapshot!=null){
          Map<dynamic,dynamic> alldata=snapshot.value;
          //print(lt.length);
         // print(alldata.toString());
          if(!alldata.containsKey(today)){
            loadBooktoday=false;
          }
          if(alldata!=null){
            alldata.forEach((key,value){
              if(key.toString().compareTo('number')!=0){
                val=DateFormat(r'''MMMM dd, yyyy''').parse(key);
               // print(DateFormat(r'''MMMM dd, yyyy''').parse(key));
                if(DateFormat(r'''MMMM dd, yyyy''').parse(DateFormat.yMMMMd('en_US').format(DateTime.now())).compareTo(val)>0){
                  if(key!=null)
                    value['patientinfo'].forEach((val){
                      if(val!=null){
                        oldbookingList.add(val);
                      }
                    });
                  loadBook=false;
                  loadBookfuture=false;
                }
                int i=0;
                if(DateTime.now().compareTo(val)<0){
                  i++;
                  if(key!=null)
                    value['patientinfo'].forEach((val){
                      if(val!=null){
                        //print(val.toString());
                        futureList.add(val);
                      }
                    });
                  loadBookfuture=false;
                }
              }
            });
            //print(dats.toString());
            return futureList;
          }
        }
        return false;
      });
    }catch(e){
      print('Error');
    }
  }
  Future deleteEntry(String email,String date,int i)async{
    String s=codedEmail(email);
    DBRef.child(s).child(date).child('patientinfo').child('${i}').remove().then((_){
      print('removed');
    });
    return null;
  }
}