part of 'calculator_information_cubit.dart';

abstract class CalculatorInformationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CalculatorInformationLoading extends CalculatorInformationState {}

class CalculatorInformationLoaded extends CalculatorInformationState {
  CalculatorInformationLoaded(this.records);

  final CalculatorInformationResponse? records;

  bool hasDetailedInformation(String fullKey) {
    return records?.byKey.containsKey(fullKey) ?? false;
  }

  CalculatorInformationRecord? getDetailedInformation(String fullKey) {
    return records?.byKey[fullKey];
  }
}
