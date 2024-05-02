import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorEvent {}

class ColorPressedEvent extends ColorEvent {}

class SwitchAnimationStateEvent extends ColorEvent {
}

class ColorBloc extends Bloc<ColorEvent, ColorSelection> {
  ColorBloc()
      : super(ColorSelection(
            colorText: getColorText(1), solutionIndex: 1, confettiState: ConfettiState.inactive)) {
    on<ColorPressedEvent>((event, emit) {
      final random = Random();
      int randomNumber = random.nextInt(3) + 1;
      emit(state.copyWith(solutionIndex: randomNumber, colorText: getColorText(randomNumber), dinos: state.dinos + 1));
    });
    on<SwitchAnimationStateEvent>((event, emit) {
      emit(state.copyWith(confettiState: state.confettiState.getOther()));
    });
  }
}

class ColorSelection extends Equatable {
  final String _colorText;
  final int _solutionIndex;
  final ConfettiState _confettiState;
  final int _dinos;
  static final List<String> _images = [
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

  const ColorSelection({
    required String colorText,
    required int solutionIndex,
    required ConfettiState confettiState,
    int? dinos,
  })  : _colorText = colorText,
        _solutionIndex = solutionIndex,
        _confettiState = confettiState,
        _dinos = dinos ?? 0;

  ColorSelection copyWith({
    String? colorText,
    int? solutionIndex,
    ConfettiState? confettiState,
    int? dinos,
  }) {
    return ColorSelection(
      colorText: colorText ?? _colorText,
      solutionIndex: solutionIndex ?? _solutionIndex,
      confettiState: confettiState ?? _confettiState,
      dinos: dinos ?? _dinos,
    );
  }

  String getImage(int position) {
    return _images[position + 3 * (_dinos % (_images.length / 3).round())];
  }

  int get solutionIndex => _solutionIndex;

  String get colorText => _colorText;

  ConfettiState get confettiState => _confettiState;

  int get dinos => _dinos;

  @override
  List<Object> get props => [_colorText, _confettiState, _solutionIndex, _dinos];
}

String getColorText(int solutionIndex) {
  switch (solutionIndex % 3) {
    case 0:
      return "Blau";
    case 1:
      return "Rot";
    case 2:
    default:
      return "Grün";
  }
}

enum ConfettiState {
  active,
  inactive;

  ConfettiState getOther() {
    return this == ConfettiState.active ? ConfettiState.inactive : ConfettiState.active;
  }
}