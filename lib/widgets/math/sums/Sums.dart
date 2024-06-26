import 'package:colorman/widgets/TextToSpeech.dart';
import 'package:colorman/widgets/math/sums/Question.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              body: BlocBuilder<SumsBloc, SumData>(
                builder: (context, numbers) {
                  return Column(children: [
                    SizedBox(
                        child: QuestionTile(question: numbers.getQuestion())),
                    SizedBox(height: 20),
                    Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            _generateNumberContainers(numbers.num1, Colors.blue)
                              ..addAll([
                                Text(
                                  numbers.getOperator(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ])
                      ..addAll(_generateNumberContainers(
                          numbers.num2, Colors.green)),
                  ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.all(24),
                      child: TextFormField(
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 30,
                        ),
                        focusNode: inputNode,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onFieldSubmitted: (value) {
                          if (numbers.getAnswer() == int.parse(value)) {
                            textToSpeech.speak("${value} Das ist richtig!");
                            confettiController.play();
                          } else {
                            textToSpeech
                                .speak("${value} Das war leider nichts!");
                          }
                          Future.delayed(Duration(seconds: 2), () {
                            sumsBloc.add(NumberPressedEvent());
                            confettiController.stop();
                            textEditingController.clear();
                            openKeyboard();
                          });
                        },
                        decoration: InputDecoration(hintText: "Lösung"),
                      ),
                    ),
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

  List<Widget> _generateNumberContainers(int count, Color color) {
    return List.generate(
      count,
      (index) => Container(
        margin: EdgeInsets.all(4),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
