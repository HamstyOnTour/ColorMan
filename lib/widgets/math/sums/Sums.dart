import 'package:colorman/widgets/math/event/CountingEvent.dart';
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
  
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final SumsBloc numberBloc = BlocProvider.of<SumsBloc>(context);
    return BlocProvider(
        create: (context) => numberBloc,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              appBar: AppBar(
                title: Text('Number List'),
              ),
              body: BlocBuilder<SumsBloc, Map<String, String>>(
                builder: (context, numbers) {
                  return Column(children: [
                    SizedBox(
                        child: QuestionTile(question: numbers["Q"])),
                    SizedBox(height: 20),
                    TextField(
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
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
