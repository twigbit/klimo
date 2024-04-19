import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:klimo/components/calculator/calculator_repository.dart';
import 'package:klimo_datamodels/calculation_engine.dart';

import '../../../config/firebase.dart';

part 'calculator_update_state.dart';

class CalculatorUpdateCubit extends Cubit<CalculatorUpdateState>
    with ErrorHandling {
  final CalculatorRepository calculatorRepository;

  CalculatorUpdateCubit(this.calculatorRepository)
      : super(CalculatorUpdateInitial());

  @override
  void onChange(Change<CalculatorUpdateState> change) {
    super.onChange(change);
  }

  Future<bool> storeUpdatedUserValues(CalculationSnapshot data) async {
    emit(CalculatorUpdateLoading());
    try {
      await calculatorRepository.saveCalculationSnapshot(data);
      emit(CalculatorUpdateLoaded());
      return true;
    } catch (error) {
      debugPrint(error.toString());
      emit(CalculatorUpdateError());
      return false;
    }
  }

  void reset() {
    emit(CalculatorUpdateInitial());
  }
}
