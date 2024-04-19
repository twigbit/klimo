import 'package:klimo_datamodels/klimo/klimo_calculation_model/consumption/consumption.dart';
import 'package:klimo_datamodels/klimo/klimo_calculation_model/mobility/mobility.dart';
import 'package:klimo_datamodels/klimo/klimo_calculation_model/nutrition.dart';

import '../calculation_model.dart';
import 'compensation.dart';
import 'klimo_calculation_model/living.dart';
import 'klimo_input_model.dart';

// ignore: non_constant_identifier_names
final KlimoCalculationModel = CalculationModel(buildKlimoCalculationModel);

void buildKlimoCalculationModel(CalculationModelBuilder m) => m
  ..name = "Klimo"
  ..version = "1"
  ..inputModel.update(buildKlimoInputModel)
  ..sectionCalculationMapping.addEntries([
    MapEntry("living", "living"),
    MapEntry("mobility", "mobility"),
    MapEntry("nutrition", "nutrition"),
    MapEntry("consumption", "consumption"),
    MapEntry("public", "public"),
    MapEntry("compensation", "compensation"),
  ])
  ..nodes.addAll([
    FormulaNode(buildLivingSection),
    FormulaNode(buildMobilitySection),
    FormulaNode(buildNutritionSection),
    FormulaNode(buildConsumptionSection),
    FormulaNode((n) => n
      ..key = "public"
      ..footprint((_, __) => 0.74)),
    FormulaNode(buildCompensationSection),
  ]);
