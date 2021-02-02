import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends PreferredSize {
  Widget build(BuildContext context) {
    return PreferredSize(
        child: Container(
          height: 120.0,
          padding: EdgeInsets.only(top: 30.0),
          child: Stack(
            children: [
              Center(
                child: SvgPicture.asset('assets/talks.svg'),
              ),
              Positioned(
                child: InkWell(
                  onTap: () {
                    // _scaffoldKey.currentState.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
                left: MediaQuery.of(context).size.width * 0.08,
                top: 30.0,
              ),
              Positioned(
                child: Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                right: MediaQuery.of(context).size.width * 0.17,
                top: 30.0,
              ),
              Positioned(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                right: MediaQuery.of(context).size.width * 0.08,
                top: 30.0,
              )
            ],
          ),
        ),
        preferredSize: Size.fromHeight(100.0));
  }
}
