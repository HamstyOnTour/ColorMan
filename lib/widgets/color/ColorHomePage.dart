import 'package:colorman/widgets/TextToSpeech.dart';
import 'package:colorman/widgets/color/event/ColorEvent.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/ImageWidget.dart';

class ColorHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColorBloc(),
      child: ColorView(),
    );
  }
}

class ColorView extends StatelessWidget {
  final TextToSpeech textToSpeech = TextToSpeech();
  final confettiController = ConfettiController();
  bool _isProcessing = false;

  void _checkSelection(int state, ColorBloc bloc) {
    if (!_isProcessing) {
      _isProcessing = true;
    } else {
      return;
    }
    if (state == bloc.state.solutionIndex % 3) {
      textToSpeech.speak("RICHTIG");
      confettiController.play();
    } else {
      textToSpeech.speak("Leider falsch");
    }
    Future.delayed(Duration(seconds: 2), () {
      _isProcessing = false;
      bloc.add(ColorPressedEvent());
      confettiController.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorBloc colorBloc = BlocProvider.of<ColorBloc>(context);
    return BlocProvider(
        create: (context) => colorBloc,
        child: Stack(alignment: Alignment.center, children: [
          Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: Text("Farben"),
              ),
              body: BlocBuilder<ColorBloc, ColorSelection>(
                  builder: (context, selection) {
                textToSpeech
                    .speak("Welcher Dino ist ${colorBloc.state.colorText}?");
                return Stack(alignment: Alignment.center, children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ImageWidget(
                            imagePath: colorBloc.state.getImage(0),
                            text: "BLAU",
                            height: 200,
                            width: 200,
                            onClick: () {
                              _checkSelection(0, colorBloc);
                            },
                          ),
                          ImageWidget(
                            imagePath: colorBloc.state.getImage(1),
                            text: "ROT",
                            height: 200,
                            width: 200,
                            onClick: () {
                              _checkSelection(1, colorBloc);
                            },
                          ),
                          ImageWidget(
                            imagePath: colorBloc.state.getImage(2),
                            text: "GRÜN",
                            height: 200,
                            width: 200,
                            onClick: () {
                              _checkSelection(2, colorBloc);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: FloatingActionButton(
                      onPressed: () async {
                        textToSpeech.speak(colorBloc.state.colorText);
                      },
                      tooltip: 'Color',
                      backgroundColor: Colors.amber,
                      child: const Icon(Icons.speaker),
                    ),
                    // This trailing comma makes auto-formatting nicer for build methods.
                  ),
                  ConfettiWidget(
                    confettiController: confettiController,
                    shouldLoop: false,
                    blastDirectionality: BlastDirectionality.explosive,
                  )
                ]);
              })),
        ]));
  }
}
