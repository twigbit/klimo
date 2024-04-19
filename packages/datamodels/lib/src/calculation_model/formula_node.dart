import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import 'calculation_node.dart';

part 'formula_node.g.dart';

typedef FootprintFn = num Function(InputGetter input, RefGetter ref);

abstract class FormulaNode
    implements CalculationNode, Built<FormulaNode, FormulaNodeBuilder> {
  @override
  String get key;

  FootprintFn get footprintFn;

  BuiltList<CalculationNode> get nodes;

  @override
  @memoized
  BuiltMap<String, CalculationNode> get pathSegments => BuiltMap.build((b) {
        b.addEntries([MapEntry(key, this)]);
        for (var n in nodes) {
          b.addAll(n.pathSegments
              .map((path, node) => MapEntry("$key.$path", node))
              .toMap());
        }
      });

  FormulaNode._();
  factory FormulaNode([void Function(FormulaNodeBuilder)? updates]) =
      _$FormulaNode;

  factory FormulaNode.param(String key, num value) => FormulaNode((b) => b
    ..key = key
    ..footprint((_, __) => value));
}

extension FormulaNodeFootprintCallback on FormulaNodeBuilder {
  void footprint(FootprintFn fn) {
    footprintFn = fn;
  }
}
