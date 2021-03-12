import 'package:flutter/material.dart';
import 'package:talks_beta/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xFF2398FF),
        hoverColor: Color(0xFF2297FE),
        buttonColor: Color(0xFF454545),
        accentColor: Color(0xFFD1E0EC),
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: SplashScreen(),
      // routes: {
      //   "/home": (context) => HomePage(),
      //   "/title": (context) => NewRecordTitlePage(),
      //   "/body": (context) => NewRecordBodyPage(),
      // },
    );
  }
}
