import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:klimo/utils/iterable.dart';
import 'package:klimo/components/auth/cubit/auth_cubit.dart';
import 'package:klimo/components/calculator/calculator_repository.dart';
import 'package:klimo/components/calculator/update_cubit/calculator_update_cubit.dart';
import 'package:klimo/config/analytics.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo_datamodels/calculation_engine.dart';
import 'package:klimo_datamodels/calculation_model.dart';
import 'package:klimo_datamodels/input_model.dart';
import 'package:klimo_datamodels/klimo/klimo_calculation_model.dart';

import '../../community/cubit/user_community_cubit.dart';
import 'calculator_value_scope_cubit.dart';

part 'calculator_state.dart';

class CalculatorCubit extends Cubit<CalculatorState> with ErrorHandling {
  final AuthCubit _authCubit;
  final UserCommunityCubit _communityCubit;

  CalculatorRepository calculatorRepository;
  late CalculatorUpdateCubit updateCubit;

  UserValues? _savedValues;
  StreamSubscription? _sub;
  StreamSubscription? _authSub;

  late final CalculationModel calculationModel;
  late final CalculationEngine _calculationEngine;

  CalculatorCubit(this._authCubit, this._communityCubit)
      : assert(_authCubit.state.value?.uid != null,
            "Calculator cubit must be created in authenticated context"),
        calculatorRepository =
            CalculatorRepository(_authCubit.state.value!.uid),
        super(CalculatorLoading()) {
    calculationModel = KlimoCalculationModel;
    _calculationEngine = CalculationEngine(calculationModel: calculationModel);

    updateCubit = CalculatorUpdateCubit(calculatorRepository);

    _authSub = _authCubit.stream
        .map<String?>((event) => event.value?.uid)
        .where((event) => event != null)
        .listen((uid) {
      calculatorRepository = CalculatorRepository(uid!);
      updateCubit = CalculatorUpdateCubit(calculatorRepository);
      initialize();
    });
  }

  bool checkCondition(Input input) {
    if (input.condition == null) return true;
    return _calculationEngine.evaluateCondition(input.condition!);
  }

  @override
  Future<void> close() {
    _authSub?.cancel();
    _sub?.cancel();
    _rootValueScopeSub?.cancel();
    _rootValueScope?.close();
    return super.close();
  }

  StreamSubscription? _rootValueScopeSub;
  CalculatorValueScopeCubit? _rootValueScope;

  CalculatorValueScopeCubit _createRootValueScope() {
    final current = state;
    if (current is! CalculatorReady) {
      throw StateError(
          "CalculatorCubit.createValueScope may only be called in CalculatorReady state.");
    }
    final c = CalculatorValueScopeCubit(
        scope: current.inputModel, initialValues: current.userValues);
    _attachRootValueScopeListener(c);
    return c;
  }

  void _attachRootValueScopeListener(CalculatorValueScopeCubit c) {
    assert(state is CalculatorReady);
    _rootValueScopeSub = c.stream.listen((v) {
      assert(v is UserValues);
      final res = _recalculate(v as UserValues);
      emit((state as CalculatorReady)._copyWith(
        userValues: v,
        calculationResults: res,
        hasUnsavedChanges: true,
      ));

      if (_scheduledSave) {
        updateUserValues();
        _scheduledSave = false;
      }
    });
  }

  CalculatorValueScopeCubit get rootValueScope {
    return _rootValueScope ??= _createRootValueScope();
  }

  void resetScope() {
    assert(_savedValues != null);

    final calculationResults = _recalculate(_savedValues!);

    _rootValueScopeSub?.cancel();
    if (_rootValueScope != null) {
      _rootValueScope!.emit(_savedValues!);
      _attachRootValueScopeListener(_rootValueScope!);
    }

    emit(CalculatorReady(
      inputModel: _calculationEngine.calculationModel.inputModel,
      userValues: _savedValues!,
      calculationResults: calculationResults,
      hasUnsavedChanges: false,
    ));
    _scheduledSave = false;
  }

  bool _scheduledSave = false;
  void scheduleSave() {
    _scheduledSave = true;
  }

  void initialize() async {
    updateCubit.reset();
    _sub?.cancel();
    _sub = calculatorRepository.lastUserCalculation.snapshots().listen((snap) {
      final userValues = snap.docs.safeFirst != null
          ? snap.docs.safeFirst!.data().userValues
          : UserValues((b) => b
            ..inputModelName = calculationModel.inputModel.name
            ..inputModelVersion = calculationModel.inputModel.version
            ..values.addEntries([]));
      _savedValues = userValues;
      resetScope();
    });
  }

  // ignore: non_constant_identifier_names
  Object? unstable__getNestedValue(NestedEntityInput input, int index) {
    final current = state;
    if (current is CalculatorReady) {
      final path = current.inputModel.resolveInput(input);
      if (path == null) return null;
      return _calculationEngine.unstable__getValue("$path.$index");
    } else {
      throw StateError(
          "CalculatorCubit.updateUserValues may only be called in CalculatorReady state.");
    }
  }

  /// Takes the last user inputs and calculation results and saves them to Firestore.
  Future<void> updateUserValues([String? sectionKey]) async {
    final current = state;
    if (current is CalculatorReady) {
      final data = CalculationSnapshot((b) => b
        ..userValues.replace(current.userValues)
        ..calculationResults.replace(current.calculationResults));

      if (await updateCubit.storeUpdatedUserValues(data)) {
        emit(current._copyWith(hasUnsavedChanges: false));
      }

      //log calculation results
      if (sectionKey != null) {
        final calculationResults = _recalculate(_savedValues!);
        analytics.logUpdateCalculatorSection(
          params: {
            AnalyticsParameters.footprintSection: sectionKey,
            AnalyticsParameters.value:
                current.calculationResults.sectionResults[sectionKey],
            AnalyticsParameters.previousValue:
                calculationResults.sectionResults[sectionKey],
          },
        );
      }
      analytics.logUpdateFootprint(
        params: {
          AnalyticsParameters.footprintTotal:
              current.calculationResults.totalResult,
          AnalyticsParameters.footprintLiving:
              current.calculationResults.sectionResults["living"],
          AnalyticsParameters.footprintMobility:
              current.calculationResults.sectionResults["mobility"],
          AnalyticsParameters.footprintNutrition:
              current.calculationResults.sectionResults["nutrition"],
          AnalyticsParameters.footprintConsumption:
              current.calculationResults.sectionResults["consumption"],
          AnalyticsParameters.footprintSection: sectionKey,
          AnalyticsParameters.communityId:
              _communityCubit.state?.value?.data()?.community.ref.id,
          AnalyticsParameters.communityName:
              _communityCubit.state?.value?.data()?.community.name["de"],
          AnalyticsParameters.communityNameEN:
              _communityCubit.state?.value?.data()?.community.name["en"],
          AnalyticsParameters.departmentId:
              _communityCubit.state?.value?.data()?.department?.ref.id,
          AnalyticsParameters.departmentName:
              _communityCubit.state?.value?.data()?.department?.name["de"],
          AnalyticsParameters.departmentNameEN:
              _communityCubit.state?.value?.data()?.department?.name["en"],
          AnalyticsParameters.teamId:
              _communityCubit.state?.value?.data()?.team?.ref.id,
          AnalyticsParameters.teamName:
              _communityCubit.state?.value?.data()!.team?.name,
        },
      );
    } else {
      throw StateError(
          "CalculatorCubit.updateUserValues may only be called in CalculatorReady state.");
    }
  }

  CalculationResults _recalculate(UserValues uv) {
    // TODO: (emil) move calculation to background isolate
    // WARNING: this will likely change from sync execution to background very soon.
    final result = _calculationEngine.updateCalculation(uv);
    return result;
  }
}
