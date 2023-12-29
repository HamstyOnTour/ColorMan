import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class NumberEvent{}
class NumberPressedEvent extends NumberEvent {}

class NumberBloc extends Bloc<NumberEvent, Map<String, List<int>>> {
  int listLength = 5;
  NumberBloc() : super({"Q": [1, 2, 3, 4, 5],
      "A": [6, 7, 8],
      "S": [6]})
  {
    on<NumberPressedEvent>((event, emit){
      int random = Random().nextInt(20);
      List<int> generatedList = List.generate(listLength, (index) => random + index);
      int solution = generatedList.last + 1;
      List<int> solutions = List.generate(3, (index) => solution + 2 + index);
      solutions.add(solution);
      solutions.shuffle(Random());
      Map<String, List<int>> emitted = {
        "Q":generatedList,
        "A":solutions,
        "S":[solution]
      };
      emit(emitted);
    });
  }
}
