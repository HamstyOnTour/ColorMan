import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class ColorEvent {}

class ColorPressedEvent extends ColorEvent {}

class ColorBloc extends Bloc<ColorEvent, ColorSelection> {
  ColorBloc() : super(ColorSelection(1)) {
    on<ColorPressedEvent>((event, emit) {
      final random = Random();
      int randomNumber = random.nextInt(3) + 1;
      emit(ColorSelection(randomNumber));
    });
  }
}

class ColorSelection {
  String _colorText = "";
  final int _solutionIndex;
  static int _dinos = 0;
  List<String> _images = [];

  ColorSelection(this._solutionIndex) {
    switch (_solutionIndex % 3) {
      case 0:
        _colorText = "Blau";
        break;
      case 1:
        _colorText = "Rot";
        break;
      case 2:
      default:
        _colorText = "Grün";
    }
    _images = [
      'images/blueTRex.jpeg',
      'images/redTRex.jpeg',
      'images/greenTRex.jpeg',
      'images/brontosaurusBlue.jpeg',
      'images/brontosaurusRed.jpeg',
      'images/brontosaurusGreen.jpeg',
      'images/triceratopsBlue.jpeg',
      'images/triceratopsRed.jpeg',
      'images/triceratopsGreen.jpeg',
      'images/mosasaurusBlue.jpeg',
      'images/mosasaurusRed.jpeg',
      'images/mosasaurusGreen.jpeg',
      'images/brontosaurusBlue2.jpeg',
      'images/brontosaurusRed2.jpeg',
      'images/brontosaurusGreen2.jpeg'
    ];

    _dinos++;
  }

  String getImage(int position) {
    return _images[position + 3 * (_dinos % (_images.length / 3).round())];
  }

  int get solutionIndex => _solutionIndex;

  String get colorText => _colorText;
}
