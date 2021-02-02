import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RecordButton extends StatefulWidget {
  String text;
  final TextEditingController textEditingController;
  final stt.SpeechToText speechToText;
  final Timer timer;

  RecordButton(
      {this.text, this.textEditingController, this.speechToText, this.timer});

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  bool _isListening;
  int _seconds;
  int _mins;
  int _hours;
  Timer _timer;
  stt.SpeechToText _speech;

  @override
  void initState() {
    _isListening = false;
    _seconds = 0;
    _mins = 0;
    _hours = 0;
    _speech = stt.SpeechToText();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _speech?.cancel();
    super.dispose();
  }

  void temporaryDispose() {
    _timer?.cancel();
    _speech?.cancel();
  }

  void _startTimer() => _timer = Timer.periodic(
        Duration(seconds: 1),
        (timer) {
          setState(() {
            if (_seconds == 59) {
              _seconds = 0;
              _mins++;
            } else {
              _seconds++;
            }
          });
        },
      );

  void _startRecord() async {
    if (_timer != null) {
      _timer.cancel();
    }
    bool available = await _speech.initialize(
      onStatus: (val) {
        print('onStatus: $val');

        if (val != 'listening') {
          setState(() {
            _isListening = false;
          });
          _timer.cancel();
        }
      },
      onError: (val) {
        print('onError: $val');
        // _stopRecord();
        setState(() {
          _isListening = false;
        });
      },
      // options: []
    );

    if (available) {
      setState(() {
        _isListening = true;
      });

      _speech.listen(
        listenFor: Duration(seconds: 10),
        pauseFor: Duration(seconds: 10),
        cancelOnError: true,
        listenMode: stt.ListenMode.confirmation,
        onResult: (result) => setState(
          () {
            widget.textEditingController.text = result.recognizedWords;
          },
        ),
      );
      // setState(() {});
      _startTimer();
    }
  }

  String _stopRecord() {
    _timer?.cancel();

    setState(() {
      _isListening = false;
      _seconds = 0;
      _mins = 0;
      _hours = 0;
    });
    _speech.stop();
    return '';
  }

  String _showTimer() {
    var hour = _hours.toString().length == 0 ? '00' : '0$_hours';
    var minute = _mins.toString().length == 0
        ? '00'
        : _mins.toString().length == 1
            ? '0$_mins'
            : '$_mins';

    var second = _seconds.toString().length == 0
        ? '00'
        : _seconds.toString().length == 1
            ? '0$_seconds'
            : '$_seconds';

    return '$hour:$minute:$second';
  }

  String get text {
    setState(() {});
    widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AvatarGlow(
          animate: true,
          glowColor: Colors.white,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: SizedBox(
            height: 100.0,
            width: 100.0,
            child: _isListening
                ? RaisedButton(
                    elevation: 15.0,
                    color: Theme.of(context).buttonColor,
                    child: Icon(
                      Icons.stop,
                      color: Colors.white,
                      size: 50.0,
                    ),
                    onPressed: () => _stopRecord(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  )
                : RaisedButton(
                    elevation: 15.0,
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(18.0),
                      child: SvgPicture.asset('assets/micro.svg'),
                    ),
                    onPressed: () => _startRecord(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                  ),
          ),
        ),
        _isListening
            ? SizedBox(
                height: 15.0,
                child: Text(
                  _isListening ? '${_showTimer()}' : '${_stopRecord()}',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                  ),
                ),
              )
            : Container(
                height: 15.0,
              ),
      ],
    );
  }
}
