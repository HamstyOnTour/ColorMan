import 'package:colorman/widgets/ColoredBoxWidget.dart';
import 'package:colorman/widgets/TextToSpeech.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColorMan',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'ColorMan'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        final random = Random();
        int randomNumber = random.nextInt(3) + 1;
        _counter += randomNumber;
      });
    } else {
      textToSpeech.speak("Leider falsch");
      setState(() {
        isConfetti = false;
        confettiController.stop();
        final random = Random();
        int randomNumber = random.nextInt(3) + 1;
        _counter += randomNumber;
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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
