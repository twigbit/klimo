part of 'calculator_cubit.dart';

abstract class CalculatorState extends Equatable {
  const CalculatorState();

  @override
  List<Object?> get props => [];
}

class CalculatorLoading extends CalculatorState {}

class CalculatorReady extends CalculatorState {
  final InputModel inputModel;
  final UserValues userValues;
  final CalculationResults calculationResults;

  final bool hasUnsavedChanges;

  Object? getInputValue(Input input) {
    final path = inputModel.resolveInput(input);
    if (path == null) return null;
    return userValues.values[path];
  }

  bool isSectionEmpty(String sectionKey) {
    return !userValues.values.keys.any((k) => k.startsWith(sectionKey));
  }

  const CalculatorReady({
    required this.inputModel,
    required this.userValues,
    required this.calculationResults,
    required this.hasUnsavedChanges,
  }) : super();

  @override
  List<Object?> get props => [
        inputModel,
        userValues,
        calculationResults,
        hasUnsavedChanges,
      ];

  CalculatorReady _copyWith({
    UserValues? userValues,
    CalculationResults? calculationResults,
    bool? hasUnsavedChanges,
  }) =>
      CalculatorReady(
        inputModel: inputModel,
        userValues: userValues ?? this.userValues,
        calculationResults: calculationResults ?? this.calculationResults,
        hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
      );
}
