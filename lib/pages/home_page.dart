import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talks_beta/components/custom_appbar.dart';
import 'package:talks_beta/components/footer.dart';
import 'package:talks_beta/pages/new_record_content_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar().build(context),
      drawer: Drawer(),
      body: Stack(
        children: [
          Container(
            child: Image.asset("assets/zz.png"),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 5.0, left: 35.0),
                child: Row(
                  children: [
                    Text(
                      'NÃO PERCA TEMPO DIGITANDO!',
                      style: GoogleFonts.roboto(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).hoverColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 35.0, right: 35.0),
                child: Text(
                  'REGISTRE SUAS IDEIAS USANDO APENAS A VOZ.',
                  style: GoogleFonts.roboto(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 40, top: 10.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: EdgeInsets.all(15.0),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => NewRecordContentPage(),
                        ),
                      ),
                      child: Text(
                        '+ Novo Registro',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.transparent,
                height: 20.0,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.45,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 1,
                  // enableInfiniteScroll: true,
                  reverse: false,
                  // autoPlay: façs,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  // autoPlayCurve: Curves.fastOutSlowIn,
                  // enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: [1, 2, 3].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(1.0, 5.0))
                            ],
                            color: i % 2 != 0
                                ? Colors.white
                                : Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Ideia de estudo',
                                  style: TextStyle(
                                      fontSize: 18.0, color: Colors.white),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.transparent,
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, Body 2: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor...',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              Footer()
            ],
          )
        ],
      ),
    );
  }
}
