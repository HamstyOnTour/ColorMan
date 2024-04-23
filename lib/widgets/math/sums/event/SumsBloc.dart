import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class NumberEvent {}

class NumberPressedEvent extends NumberEvent {}

class SumsBloc extends Bloc<NumberEvent, Map<String, String>> {
  int listLength = 5;

  SumsBloc() : super({"Q": " 1 + 1 = ?",
    "A": "2"}) {
    on<NumberPressedEvent>((event, emit) {
      Random random = Random();
      int num1 = random.nextInt(10) + 1; // Random number between 1 and 20
      int num2 = random.nextInt(5) + 1;
      int sum = num1 + num2;
      String question = '$num1 + $num2 = ?';
      String answer = sum.toString();
      Map<String, String> emitted = {
        "Q": question,
        "A": answer
      };
      emit(emitted);
    });
  }
}
