import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import 'calculation_node.dart';
import 'formula_node.dart';

part 'nested_node.g.dart';

abstract class NestedNode implements CalculationNode, Built<NestedNode, NestedNodeBuilder> {
  @override
  String get key;

  /// Path to the [NestedEntityInput] in the input model.
  String get input;

  BuiltList<CalculationNode> get nodes;

  @override
  @memoized
  BuiltMap<String, CalculationNode> get pathSegments => BuiltMap.build((b) {
        b.addEntries([MapEntry(key, this)]);
        for (var n in nodes) {
          b.addAll(n.pathSegments.map((path, node) => MapEntry("$key.$path", node)).toMap());
        }
      });

  NestedNode._();

  factory NestedNode([void Function(NestedNodeBuilder)? updates]) = _$NestedNode;
}

extension NestedNodeBuilderShorthands on NestedNodeBuilder {
  void entityType(String key, [void Function(FormulaNodeBuilder)? updates]) {
    nodes.add(FormulaNode((n) => n
      ..update(updates)
      ..key = key));
  }
}
