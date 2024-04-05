import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class NumberEvent {}

class NumberPressedEvent extends NumberEvent {}

class SumsBloc extends Bloc<NumberEvent, Map<String, String>> {
  int listLength = 5;

  SumsBloc() : super({"Q": " 1 + 1 = ?",
    "A": "2"}) {
    on<NumberPressedEvent>((event, emit) {
      int random = Random().nextInt(20);
      List<int> generatedList = List.generate(
          listLength, (index) => random + index);
      int solution = generatedList.last + 1;

      Map<String, String> emitted = {
        "Q": "1 + 2 = ?",
        "A": "3"
      };
      emit(emitted);
    });
  }
}
