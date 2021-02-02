import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talks_beta/components/footer.dart';

class EditableRecordPage extends StatefulWidget {
  final String title;

  const EditableRecordPage({Key key, this.title}) : super(key: key);
  @override
  _EditableRecordPageState createState() => _EditableRecordPageState();
}

class _EditableRecordPageState extends State<EditableRecordPage> {
  final _textController = TextEditingController();
  final _titleController = TextEditingController();

  static const double HEIGTH = 120.0;

  @override
  void initState() {
    _textController.text = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          height: HEIGTH,
          padding: EdgeInsets.only(top: 20.0),
          child: Stack(
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/talks.svg',
                  height: MediaQuery.of(context).size.width * 0.18,
                ),
              ),
              Positioned(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                left: MediaQuery.of(context).size.width * 0.08,
                top: 30.0,
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(100.0),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - HEIGTH,
          child: Column(
            children: [
              Container(
                height: 50.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)),
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.12,
                  right: MediaQuery.of(context).size.width * 0.12,
                ),
                child: TextField(
                  controller: _titleController,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  style: GoogleFonts.roboto(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Defina um título',
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: 8.0,
              ),
              Text(
                'Passo 2 - Edição ',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 20.0,
                color: Colors.transparent,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.12,
                  right: MediaQuery.of(context).size.width * 0.12,
                ),
                child: TextField(
                  controller: _textController,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                  maxLines: 5,
                  decoration: InputDecoration(
                    // hintText: _text,
                    hintStyle: GoogleFonts.roboto(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Divider(
                height: 20.0,
                color: Colors.transparent,
              ),
              Container(
                height: 45.0,
                width: 200.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Text(
                    'Salvar Registro',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              // Text(
              //   'Quer aprender a desenvolver esse APP?',
              //   style: GoogleFonts.roboto(
              //     color: Colors.white,
              //     fontSize: 16.0,
              //   ),
              // ),
              Footer()
            ],
          ),
        ),
      ),
    );
  }
}
