import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../TextToSpeech.dart';
import 'event/CountingEvent.dart';
import 'NumberTile/NumberTile.dart';

class CountingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NumberBloc(),
      child: CountingView(),
    );
  }
}

class CountingView extends StatelessWidget {

  final confettiController = ConfettiController();

  @override
  Widget build(BuildContext context) {
    final NumberBloc countingBloc = BlocProvider.of<NumberBloc>(context);
    final TextToSpeech textToSpeech = TextToSpeech();
    return BlocProvider(
      create: (context) => countingBloc,
      child: Stack(alignment: Alignment.center, children: [
        Scaffold(
          appBar: AppBar(
            title: Text('Number List'),
          ),
          body: BlocBuilder<NumberBloc, Map<String, List<int>>>(
            builder: (context, numbers) {
              var list = numbers["Q"];
              return Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: list!.length,
                      itemBuilder: (context, index) {
                        return NumberTile(number: list[index]);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  buildButtonRow(
                      numbers["A"]!.sublist(0, numbers["A"]!.length ~/ 2),
                      numbers,
                      textToSpeech,
                      countingBloc),
                  SizedBox(height: 20),
                  buildButtonRow(
                      numbers["A"]!.sublist(numbers["A"]!.length ~/ 2),
                      numbers,
                      textToSpeech,
                      countingBloc),
                ],
              );
            },
          ),
        ),
        ConfettiWidget(
          confettiController: confettiController,
          shouldLoop: false,
          blastDirectionality: BlastDirectionality.explosive,
        ),
      ]),
    );
  }

  Row buildButtonRow(List<int> buttons, Map<String, List<int>> numbers,
      TextToSpeech textToSpeech, NumberBloc countingBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .map((value) => ElevatedButton(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.all(50.0)),
              onPressed: () {
                if (value == numbers["S"]!.first) {
                  textToSpeech.speak("${value} Das ist richtig!");
                  confettiController.play();
                } else {
                  textToSpeech.speak("${value} Das war leider nichts!");
                }
                Future.delayed(Duration(seconds: 2), () {
                  countingBloc.add(NumberPressedEvent());
                  confettiController.stop();
                });
              },
              child: Text(
                value.toString(),
                style: TextStyle(fontSize: 20.0),
              )))
          .toList(),
    );
  }
}
