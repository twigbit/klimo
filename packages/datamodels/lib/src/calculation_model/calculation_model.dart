import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import '../../input_model.dart';
import 'calculation_node.dart';

part 'calculation_model.g.dart';

/// The CalculationModel class provides the entrypoint for constructing
/// a model of all formulae relevant in calculating the emissions of the user.
abstract class CalculationModel implements Built<CalculationModel, CalculationModelBuilder> {
  String get name;

  String get version;

  InputModel get inputModel;

  /// A map of section keys from the input model to calculation paths used to
  /// attribute calculation results to individual sections.
  BuiltMap<String, String> get sectionCalculationMapping;

  BuiltList<CalculationNode> get nodes;

  @memoized
  BuiltMap<String, CalculationNode> get pathLUT => BuiltMap.build((b) {
        for (var n in nodes) {
          b.addAll(n.pathSegments.toMap());
        }
      });

  CalculationModel._() {
    // validate unique constraint on section keys
    // Set keys = Set<String>();
    // sections.forEach((section) {
    //   if (keys.contains(section.key)) {
    //     throw new ArgumentError(
    //         "duplicate section key \"${section.key}\" provided");
    //   }
    //   keys.add(section.key);
    // });
  }

  factory CalculationModel([void Function(CalculationModelBuilder)? updates]) = _$CalculationModel;
}
