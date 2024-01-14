import 'dart:math';

import 'package:colorman/widgets/TextToSpeech.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ColoredBoxWidget.dart';

class ColorHomePage extends StatefulWidget {

  const ColorHomePage({super.key, required this.title});

  final String title;
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ColorHomePage> {
  int _counter = 0;
  TextToSpeech textToSpeech = TextToSpeech();
  bool isConfetti = false;
  final confettiController = ConfettiController();

  void _speakText() {
    if (isConfetti) {
      confettiController.stop();
    }
    String text;
    switch (_counter % 3) {
      case 0:
        text = "Blau";
        break;
      case 1:
        text = "Rot";
        break;
      case 2:
      default:
        text = "Grün";
    }
    textToSpeech.speak(text);
  }

  void _checkSelection(int state) {
    if (state == _counter % 3) {
      textToSpeech.speak("RICHTIG");
      setState(() {
        isConfetti = true;
        confettiController.play();
        Future.delayed(Duration(seconds: 2), () {
          final random = Random();
          int randomNumber = random.nextInt(3) + 1;
          _counter += randomNumber;
          confettiController.stop();
          _speakText();
        });
      });
    } else {
      textToSpeech.speak("Leider falsch");
      setState(() {
        isConfetti = false;
        confettiController.stop();
        Future.delayed(Duration(seconds: 2), (){
          final random = Random();
          int randomNumber = random.nextInt(3) + 1;
          _counter += randomNumber;
          _speakText();
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    confettiController.addListener(() {
      setState(() {
        isConfetti =
            confettiController.state == ConfettiControllerState.playing;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ColoredBoxWidget(
                color: Colors.blue,
                text: "BLAU",
                onClick: () {
                  _checkSelection(0);
                },
              ),
              ColoredBoxWidget(
                color: Colors.red,
                text: "ROT",
                onClick: () {
                  _checkSelection(1);
                },
              ),
              ColoredBoxWidget(
                color: Colors.green,
                text: "GRÜN",
                onClick: () {
                  _checkSelection(2);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _speakText,
          tooltip: 'Color',
          child: const Icon(Icons.add_box_outlined),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
      ConfettiWidget(
        confettiController: confettiController,
        shouldLoop: false,
        blastDirectionality: BlastDirectionality.explosive,
      )
    ]);
  }
}
