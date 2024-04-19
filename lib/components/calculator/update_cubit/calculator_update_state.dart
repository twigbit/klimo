part of 'calculator_update_cubit.dart';

@immutable
abstract class CalculatorUpdateState extends Equatable {
  const CalculatorUpdateState();

  @override
  List<Object?> get props => [];
}

class CalculatorUpdateInitial extends CalculatorUpdateState {}

class CalculatorUpdateLoading extends CalculatorUpdateState {}

class CalculatorUpdateLoaded extends CalculatorUpdateInitial {}

class CalculatorUpdateError extends CalculatorUpdateInitial {}
