import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:talks_beta/components/custom_appbar.dart';
import 'package:talks_beta/components/footer.dart';
import 'package:talks_beta/core/databe_helper.dart';
import 'package:talks_beta/models/record.dart';
import 'package:talks_beta/pages/new_record_content_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _dbHelper = DBHelper();

  bool _checked;

  Future<List<Record>> _recordsFuture;

  @override
  void initState() {
    _checked = true;

    _recordsFuture = _dbHelper.getRecords();
    super.initState();
  }

  void _changeCardRecordsWidget() {
    setState(() {
      _checked ? _checked = false : _checked = true;
    });
  }

  String dateFormated(String value) =>
      '${DateTime.parse(value).day}/${DateTime.parse(value).month}/${DateTime.parse(value).year}';

  String hourFormated(String value) =>
      '${DateTime.parse(value).hour}:${DateTime.parse(value).minute}hs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar().build(context),
      // drawer: Drawer(),
      body: Stack(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height * 0.0,
            width: MediaQuery.of(context).size.width,
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
                    padding: EdgeInsets.only(right: 40, top: 15.0),
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
              FutureBuilder<List<Record>>(
                future: _dbHelper.getRecords(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // height: 100.0,
                      height: MediaQuery.of(context).size.height * 0.42,
                      width: MediaQuery.of(context).size.width * 0.80,
                      child: Card(
                        elevation: 15,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                    // return Expanded(
                    //   child: Center(
                    //     child: CircularProgressIndicator(),
                    //   ),
                    // );
                  }
                  return _checked
                      ? CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.42,
                            aspectRatio: 16 / 9,
                            // viewportFraction: 0.8,
                            initialPage: 1,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration: Duration(
                              milliseconds: 800,
                            ),
                            scrollDirection: Axis.horizontal,
                          ),
                          items: snapshot.data.map((record) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.70,
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
                                      color: record.id % 2 != 0
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            record != null
                                                ? record.title
                                                : 'Sem Título',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: record.id % 2 == 0
                                                  ? Colors.white
                                                  : Theme.of(context)
                                                      .primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      Text(
                                        record.content,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: record.id % 2 == 0
                                              ? Colors.white
                                              : Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${dateFormated(
                                                  record.date,
                                                )} ${hourFormated(record.date)}',
                                                style: GoogleFonts.roboto(
                                                    color: Colors.grey[400],
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.20,
                                              ),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  50.0,
                                                ),
                                                child: Icon(
                                                  Icons.share,
                                                  color: record.id % 2 == 0
                                                      ? Colors.white
                                                      : Colors.grey[500],
                                                ),
                                                onTap: () => Share.share(
                                                  record.content,
                                                ),
                                              ),
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  50.0,
                                                ),
                                                onTap: () async {
                                                  await _dbHelper.delete(
                                                    record.id,
                                                  );

                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.cancel_rounded,
                                                  color: Theme.of(context)
                                                      .buttonColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        )
                      : DefaultTabController(
                          length: 2,
                          child: Container(
                            // height: 100.0,
                            height: MediaQuery.of(context).size.height * 0.42,
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Card(
                              elevation: 15,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    child: TabBar(tabs: [
                                      Tab(
                                        text: 'Ativos',
                                      ),
                                      Tab(
                                        text: 'Arquivados',
                                      ),
                                    ]),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              4.0, 6.0, 4.0, 0.0),
                                          child: ListView.separated(
                                            padding: EdgeInsets.only(
                                                left: 6.0, right: 6.0),
                                            separatorBuilder:
                                                (context, index) => Divider(
                                              color: Colors.white,
                                            ),
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (_, index) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data[index].title,
                                                      style: GoogleFonts.roboto(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            50.0,
                                                          ),
                                                          child: Icon(
                                                            Icons.share,
                                                            color: Colors.white,
                                                          ),
                                                          onTap: () => Share
                                                              .share(snapshot
                                                                  .data[index]
                                                                  .content),
                                                        ),
                                                        InkWell(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            50.0,
                                                          ),
                                                          onTap: () async {
                                                            await _dbHelper
                                                                .delete(
                                                                    index + 1);

                                                            setState(() {});
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .cancel_rounded,
                                                            color: Theme.of(
                                                                    context)
                                                                .buttonColor,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  dateFormated(
                                                    snapshot.data[index].date,
                                                  ),
                                                  style: GoogleFonts.roboto(
                                                      color: Colors.grey[400],
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(6.0),
                                          child: ListView.builder(
                                            itemCount: snapshot.data.length,
                                            itemBuilder: (_, index) => ListTile(
                                              title: Text(
                                                  snapshot.data[index].title),
                                              subtitle: Text(
                                                dateFormated(
                                                    snapshot.data[index].date),
                                              ),
                                              trailing: Icon(
                                                Icons.cancel_outlined,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                },
              ),
              Footer()
            ],
          ),
          Positioned(
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.25,
            child: IconButton(
              iconSize: 35.0,
              icon: Icon(
                _checked ? Icons.playlist_add_check : Icons.library_books,
                color: Colors.white,
              ),
              onPressed: () => _changeCardRecordsWidget(),
            ),
          )
        ],
      ),
    );
  }
}
