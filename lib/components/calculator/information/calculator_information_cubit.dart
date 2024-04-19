import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/components/calculator/information/calculator_information_repository.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo_datamodels/calculator_information.dart';

part 'calculator_information_state.dart';

/// Cubit that provides the calculator information to the appropriate
/// calculator inputs.
class CalculatorInformationCubit extends Cubit<CalculatorInformationState>
    with ErrorHandling {
  CalculatorInformationCubit(this.calculatorInformationRepository)
      : super(CalculatorInformationLoading());

  final CalculatorInformationRepository calculatorInformationRepository;
  StreamSubscription? _sub;

  void initialize() {
    try {
      _addSubscription(
          calculatorInformationRepository.snapshots().listen((records) {
        emit(CalculatorInformationLoaded(records));
      }));
    } catch (err) {
      if (!kIsWeb) crashlytics.recordError(err, null);
      debugPrint(err.toString());
      debugPrintStack();
    }
  }

  _addSubscription(StreamSubscription sub) {
    sub.onError(onError);
    _sub = sub;
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
