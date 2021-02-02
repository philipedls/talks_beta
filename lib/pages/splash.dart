import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:talks_beta/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomePage())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: SvgPicture.asset(
          'assets/talks.svg',
          height: 120.0,
        ),
      ),
    );
  }
}
