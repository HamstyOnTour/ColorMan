import 'package:colorman/widgets/TextToSpeech.dart';
import 'package:colorman/widgets/math/sums/Question.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'event/SumsBloc.dart';

class SumsWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SumsBloc(),
      child: CalculatorView(),
    );
  }
}

class CalculatorView extends StatelessWidget {
  final confettiController = ConfettiController();
  final textEditingController = TextEditingController();
  FocusNode inputNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final SumsBloc sumsBloc = BlocProvider.of<SumsBloc>(context);

    void openKeyboard() {
      FocusScope.of(context).requestFocus(inputNode);
    }

    final TextToSpeech textToSpeech = TextToSpeech();
    return BlocProvider(
        create: (context) => sumsBloc,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text('Summen'),
              ),
              body: BlocBuilder<SumsBloc, Map<String, String>>(
                builder: (context, numbers) {
                  return Column(children: [
                    SizedBox(
                        child: QuestionTile(question: numbers["Q"])),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      focusNode: inputNode,
                      onFieldSubmitted: (value) {
                        if (value == numbers["A"]!) {
                          textToSpeech.speak("${value} Das ist richtig!");
                          confettiController.play();
                        } else {
                          textToSpeech.speak("${value} Das war leider nichts!");
                        }
                        Future.delayed(Duration(seconds: 2), () {
                          sumsBloc.add(NumberPressedEvent());
                          confettiController.stop();
                          textEditingController.clear();
                          openKeyboard();
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Lösung"
                      ),
                    )
                  ]);
                },
              ),
            ),
            ConfettiWidget(
              confettiController: confettiController,
              shouldLoop: false,
              blastDirectionality: BlastDirectionality.explosive,
            ),
          ],
        ));
  }
}
