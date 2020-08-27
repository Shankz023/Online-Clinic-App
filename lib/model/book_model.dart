import 'package:kuseswars_poly_clinic/model/doctors_model.dart';

class BookAppointment{
  DoctorsModel doc;
  String name;
  String sex;
  String age;
  String date;
  String number;
  String userNumber;
  String userName;
  String userMail;
  BookAppointment(this.doc,this.name,this.sex,this.age,this.number,this.date,this.userName,this.userMail,this.userNumber);
}