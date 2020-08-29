import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:kuseswars_poly_clinic/screens/booking_preview_screen.dart';
import 'package:kuseswars_poly_clinic/screens/helper_bot_screen.dart';
import 'package:kuseswars_poly_clinic/screens/login_screen.dart';
import 'package:kuseswars_poly_clinic/screens/profile_screen.dart';
import 'package:kuseswars_poly_clinic/screens/speciality_grid_screen.dart';
import 'package:kuseswars_poly_clinic/screens/speciality_screen.dart';
import 'package:kuseswars_poly_clinic/widgets/try_auto_login.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

bool home_book;
bool bookLoading;
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  TryAutoLogin auto= TryAutoLogin();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey[600],
        accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Colors.white54,
      ),
      home: Container(
        color: Color.fromRGBO(132, 66, 227, 1),
        child: SplashScreen('assets/animations/Splash.flr', auto.isAuth?HomeScreen():FutureBuilder(
          future: auto.autologin(),
          builder: (BuildContext context,authResultSnapshot)=>
          authResultSnapshot.connectionState==ConnectionState.waiting?CircularProgressIndicator():(auto.isAuth?HomeScreen():LoginScreen()),),
          startAnimation: 'Splash',
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/login_screen':(ctx)=>LoginScreen(),
        '/home_screen':(ctx)=>HomeScreen(),
        '/booking_preview_screen':(ctx)=>BoolinfPreviewScreen(),
        '/speciality_grid_screen':(ctx)=>SpecialityGrid(),
        //'/speciality_screen':(ctx)=>SpecialityScreen(),
        '/profile_screen':(ctx)=>ProfileScreen(),
        '/helper_bot_screen':(ctx)=>HelperBotScreen(),
      },
    );
  }
}
