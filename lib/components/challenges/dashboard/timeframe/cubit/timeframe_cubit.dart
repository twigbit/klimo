import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:klimo_datamodels/challenges.dart';

typedef TimeframeState = Timeframe;

class TimeframeCubit extends Cubit<TimeframeState> {
  final DateTime initialDate = DateTime.now();
  DateTime? _referenceDate;

  set referenceDate(DateTime? date) {
    _referenceDate = date;
    emit(Timeframe.fromTimestamp(_referenceDate!));
  }

  TimeframeCubit()
      : _referenceDate = DateTime.now(),
        super(Timeframe.fromTimestamp(DateTime.now()));

  increment() {
    referenceDate = _referenceDate!.add(const Duration(days: 7));
  }

  decrement() {
    referenceDate = _referenceDate!.subtract(const Duration(days: 7));
  }

  today() {
    referenceDate = DateTime.now();
  }

  emitFromReferenceDate() {}
}

extension Sugar on DateTime {
  int get weekNumber {
    int dayOfYear = int.parse(DateFormat("D").format(this));
    return ((dayOfYear - weekday + 10) / 7).floor();
  }
}
