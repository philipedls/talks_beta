import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:talks_beta/components/footer.dart';
import 'package:talks_beta/components/recod_button.dart';
import 'package:talks_beta/pages/editable_record_page.dart';

class NewRecordContentPage extends StatefulWidget {
  @override
  _NewRecordContentPageState createState() => _NewRecordContentPageState();
}

class _NewRecordContentPageState extends State<NewRecordContentPage> {
  RecordButton _recordButton;

  final _textController = TextEditingController();
  stt.SpeechToText _speechToText = stt.SpeechToText();

  @override
  void initState() {
    _recordButton = RecordButton(
      // text: _text,
      textEditingController: _textController,
      speechToText: _speechToText,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          height: 120.0,
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
          height: MediaQuery.of(context).size.height - 120.0,
          child: Column(
            children: [
              Text(
                'Novo Registro',
                style: GoogleFonts.roboto(
                  color: Theme.of(context).accentColor,
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                color: Colors.transparent,
                height: 8.0,
              ),
              Text(
                'Passo 1 - Conteúdo',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: Text(
                      'Cilque uma vez para dar início.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _recordButton,
                  Container(
                    width: MediaQuery.of(context).size.width * 0.22,
                    child: Text(
                      'Clique novamente para  parar.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 5.0,
                color: Colors.transparent,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.18,
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
                  maxLines: 5,
                  style: GoogleFonts.roboto(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor,
                  ),
                  decoration: InputDecoration(
                    labelText: _recordButton.text,
                    hintText: 'Grave o conteúdo',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Próximo Passo',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                        size: 30.0,
                      )
                    ],
                  ),
                  onPressed: () {
                    _speechToText?.cancel();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditableRecordPage(
                          title: _textController.text,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              RaisedButton(
                onPressed: () {},
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Text(
                  'pular etapa',
                  style:
                      GoogleFonts.roboto(color: Theme.of(context).primaryColor),
                ),
              ),
              Footer()
            ],
          ),
        ),
      ),
    );
  }
}
