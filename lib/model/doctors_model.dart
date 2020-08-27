class DoctorsModel{
  String id;
  String name;
  double fees;
  String type;

  DoctorsModel(this.id,this.name,this.fees,this.type);
}

List<DoctorsModel> doctors=[
  DoctorsModel('1', 'Dr A.K. Saha', 300.0, 'General Medicine'),
  DoctorsModel('2', 'Dr S Ghosh', 450.0, 'General Medicine'),
  DoctorsModel('2', 'Dr S Ghosh', 450.0, 'Endocrinology'),
  DoctorsModel('2', 'Dr S Ghosh', 450.0, 'Gastroentrerology'),
  DoctorsModel('2', 'Dr S Ghosh', 450.0, 'Diabetes'),
  DoctorsModel('3', 'Dr S Shaw', 250.0, 'Pediatric'),
  DoctorsModel('4', 'Dr B Sharma', 200.0, 'Dentistry'),
  DoctorsModel('5', 'Dr K Agarwal', 200.0, 'Dentistry'),
  DoctorsModel('6', 'Dr S bandhopadhyay', 350.0, 'Dermatology'),
  DoctorsModel('7', 'Dr S.P. Tiwari', 200.0, 'Orthopaedics'),
  DoctorsModel('7', 'Dr S.P. Tiwari', 200.0, 'Neurology'),
  DoctorsModel('8', 'Dr S Singh', 150.0, 'General Medicine'),
  DoctorsModel('9', 'Dr N.A. Khatun', 200.0, 'Gynecology'),
];

List<DoctorsModel> general_doctors=[
  DoctorsModel('1', 'Dr A.K. Saha', 300.0, 'General Medicine'),
  DoctorsModel('2', 'Dr S Ghosh', 450.0, 'General Medicine'),
  DoctorsModel('8', 'Dr S Singh', 150.0, 'General Medicine'),
];

List<DoctorsModel> skin=[
  DoctorsModel('6', 'Dr S bandhopadhyay', 350.0, 'Dermatology'),
];

List<DoctorsModel> ortho=[
  DoctorsModel('7', 'Dr S.P. Tiwari', 200.0, 'Orthopaedics'),
];

List<DoctorsModel> thyroid=[
  DoctorsModel('2', 'Dr S Ghosh', 450.0, 'Endocrinology'),
];

List<DoctorsModel> gas=[
  DoctorsModel('2', 'Dr S Ghosh', 450.0, 'Gastroentrerology'),
];

List<DoctorsModel> gyno=[
  DoctorsModel('9', 'Dr N.A. Khatun', 200.0, 'Gynecology'),
];

List<DoctorsModel> diabetes=[
  DoctorsModel('2', 'Dr S Ghosh', 450.0, 'Diabetes'),
];

List<DoctorsModel> child=[
  DoctorsModel('3', 'Dr S Shaw', 250.0, 'Pediatric'),
];

List<DoctorsModel> dental=[
  DoctorsModel('4', 'Dr B Sharma', 200.0, 'Dentistry'),
  DoctorsModel('5', 'Dr K Agarwal', 200.0, 'Dentistry'),
];


List<DoctorsModel> nerve=[
  DoctorsModel('7', 'Dr S.P. Tiwari', 200.0, 'Neurology'),
];
