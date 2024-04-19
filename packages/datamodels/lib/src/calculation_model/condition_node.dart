import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

import 'calculation_node.dart';

part 'condition_node.g.dart';

typedef ConditionFn = bool Function(InputGetter input, RefGetter ref);

abstract class ConditionNode
    implements CalculationNode, Built<ConditionNode, ConditionNodeBuilder> {
  @override
  String get key;

  ConditionFn get conditionFn;

  @override
  @memoized
  BuiltMap<String, CalculationNode> get pathSegments =>
      BuiltMap.of({key: this});

  ConditionNode._();
  factory ConditionNode([void Function(ConditionNodeBuilder)? updates]) =
      _$ConditionNode;
}

extension ConditionNodeFootprintCallback on ConditionNodeBuilder {
  void condition(ConditionFn fn) {
    conditionFn = fn;
  }
}
