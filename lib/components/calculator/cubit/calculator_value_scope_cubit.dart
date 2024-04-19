import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:klimo_datamodels/calculation_engine.dart';
import 'package:klimo_datamodels/input_model.dart';

import '../../../config/firebase.dart';

/// Cubit that controls the user inputs of one calculation scope.
class CalculatorValueScopeCubit extends Cubit<ValueScope> with ErrorHandling {
  final InputScope _scope;
  final String fullPathPrefix;
  late final TouchedValueScopeCubit touchedCubit;

  CalculatorValueScopeCubit({
    required InputScope scope,
    required ValueScope initialValues,
    this.fullPathPrefix = "",
  })  : _scope = scope,
        super(initialValues) {
    touchedCubit = TouchedValueScopeCubit(valueScopeCubit: this);
  }

  void setUserInput(Input input, Object? value) {
    final path = _scope.resolveInput(input);
    if (path == null) {
      throw ArgumentError.value(
          input, "input", "is not part of the current input scope");
    }

    if (state.values[path] != value) {
      final ValueScope nextState;
      if (value != null) {
        nextState = state.rebuild((state) => state.values[path] = value);
      } else {
        nextState = state.rebuild((state) => state.values.remove(path));
      }
      emit(nextState);
    }
  }

  Object? getInputValue(Input input) {
    final path = _scope.resolveInput(input);
    if (path == null) return null;
    return state.values[path];
  }

  String? getFullKey(Input input) {
    final path = _scope.resolveInput(input);
    if (path == null) return null;
    return fullPathPrefix.isEmpty ? path : "$fullPathPrefix.$path";
  }

  bool checkCondition(Input input) {
    return true; // TODO: (emil) nested conditions
    // if (input.condition == null) return true;
    // return _calculationEngine.evaluateCondition(input.condition!);
  }
}

/// Cubit that tracks, if the user interacted with a value scope
class TouchedValueScopeCubit extends Cubit<bool> {
  late final StreamSubscription<ValueScope> _valueScopeCubitSubscription;

  TouchedValueScopeCubit({required CalculatorValueScopeCubit valueScopeCubit})
      : super(false) {
    _valueScopeCubitSubscription = valueScopeCubit.stream.listen((_) {
      emit(true);
    });
  }

  @override
  Future<void> close() {
    _valueScopeCubitSubscription.cancel();
    return super.close();
  }

  void touch() {
    emit(true);
  }

  void reset() {
    emit(false);
  }
}
