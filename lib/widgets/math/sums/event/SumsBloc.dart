import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class NumberEvent {}

class NumberPressedEvent extends NumberEvent {}

class SumData{
  final int num1;
  final int num2;

  SumData(this.num1, this.num2);

  String getQuestion(){
    return '$num1 + $num2 = ?';
  }

  int getAnswer(){
    return num1 + num2;
  }

  String getOperator() {
    return "+";
  }
}

class SumsBloc extends Bloc<NumberEvent, SumData> {
  int listLength = 5;

  SumsBloc() : super(SumData(1,1)) {
    on<NumberPressedEvent>((event, emit) {
      Random random = Random();
      int num1 = random.nextInt(6) + 1;
      int num2 = random.nextInt(5) + 1;
      emit(SumData(num1, num2));
    });
  }
}
