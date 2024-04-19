import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'calculation_node.g.dart';

typedef InputGetter = T Function<T>(String path);
typedef RefGetter = T Function<T extends num>(String path);

@BuiltValue(instantiable: false)
abstract class CalculationNode {
  String get key;

  @memoized
  BuiltMap<String, CalculationNode> get pathSegments => BuiltMap();

  CalculationNode rebuild(void Function(CalculationNodeBuilder) updates);
  CalculationNodeBuilder toBuilder();
}
