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
      confettiController.play();
      bloc.add(SwitchAnimationStateEvent());
      textToSpeech.speak("RICHTIG");
    } else {
      textToSpeech.speak("Leider falsch");
    }
    Future.delayed(const Duration(seconds: 2), () {
      _isProcessing = false;
      confettiController.stop();
      bloc.add(ColorPressedEvent());
      bloc.add(SwitchAnimationStateEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorBloc colorBloc = BlocProvider.of<ColorBloc>(context);
    return BlocProvider(
      create: (context) => colorBloc,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Theme
                  .of(context)
                  .colorScheme
                  .inversePrimary,
              title: Text("Farben"),
            ),
            body: Stack(
              alignment: Alignment.center,
              children: [
                BlocBuilder<ColorBloc, ColorSelection>(
                  buildWhen: (prevState, state) =>
                  prevState.dinos != state.dinos,
                  builder: (context, state) {
                    textToSpeech.speak(
                        "Welcher Dino ist ${colorBloc.state.colorText}?");
                    return SingleChildScrollView(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _buildImageWidget(
                                colorBloc.state.getImage(0), "BLAU", 0,
                                colorBloc),
                            _buildImageWidget(
                                colorBloc.state.getImage(1), "ROT", 1,
                                colorBloc),
                            _buildImageWidget(
                                colorBloc.state.getImage(2), "GRÜN", 2,
                                colorBloc),
                          ],
                        ),
                      ),
                    );
                  },
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
                BlocBuilder<ColorBloc, ColorSelection>(
                  buildWhen: (prevState, state) =>
                  prevState.confettiState != state.confettiState,
                  builder: (context, state) {
                    return ConfettiWidget(
                      confettiController: confettiController,
                      shouldLoop: false,
                      blastDirectionality: BlastDirectionality.explosive,
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String imagePath, String text, int index,
      ColorBloc colorBloc) {
    return ImageWidget(
      imagePath: imagePath,
      text: text,
      height: 200,
      width: 200,
      onClick: () {
        _checkSelection(index, colorBloc);
      },
    );
  }
}
