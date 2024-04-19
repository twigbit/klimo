import 'package:built_collection/built_collection.dart';

import '../../calculation_model.dart';
import '../../input_model.dart';
import 'calculation_results.dart';
import 'user_values.dart';

class CalculationEngine {
  final CalculationModel calculationModel;

  late UserValues _userValues;
  Map<String, Object> _intermediateResults = {};
  CalculationResults? _calculationResults;

  CalculationEngine({required this.calculationModel});

  /// Getter that returns the results from the last calculation.
  /// This does not trigger a recalculation. Use the [updateCalculation]
  /// function, to trigger a recalculation, instead.
  CalculationResults? get calculationResults => _calculationResults;

  CalculationResults updateCalculation(UserValues userValues) {
    _intermediateResults = {};
    _userValues = userValues;

    final sectionResults = calculationModel.sectionCalculationMapping
        .map((key, path) => MapEntry(key, _evaluatePath(path, "").toDouble()));

    /// Add all section results that are non-negative.
    final totalResult =
        sectionResults.values.where((value) => value >= 0).fold<double>(
              .0,
              (val, acc) => val + acc,
            );

    return _calculationResults = CalculationResults((r) => r
      ..calculationModelName = calculationModel.name
      ..calculationModelVersion = calculationModel.version
      ..sectionResults.addAll(sectionResults.asMap())
      ..totalResult = totalResult);
  }

  bool evaluateCondition(String path) {
    assert(_calculationResults != null,
        "Calculation must be updated at least once before evaluating conditions.");
    final currentPath = _normalizePath(path, "");

    final ir = _intermediateResults[currentPath];
    if (ir != null) {
      return ir as bool;
    }

    final node = calculationModel.pathLUT[currentPath];
    if (node == null) {
      throw ArgumentError(
          "The reference '$path' (resolved to '$currentPath') was not found.");
    }
    if (node is! ConditionNode) {
      throw ArgumentError(
          "The reference '$path' (resolved to '$currentPath') is not a ConditionNode, but was expected to be one.");
    }

    final res = node.conditionFn(
      <T>(p) => _getInputValue<T>(p, currentPath),
      <T extends num>(p) => _getRefValue<T>(p, currentPath),
    );

    _intermediateResults[currentPath] = res;
    return res;
  }

  // ignore: non_constant_identifier_names
  Object? unstable__getValue(String path) {
    assert(_calculationResults != null,
        "Calculation must be updated at least once before reading values.");
    final currentPath = _normalizePath(path, "");

    return _intermediateResults[currentPath];
  }

  num _evaluatePath(String path, String base) {
    final currentPath = _normalizePath(path, base);

    final ir = _intermediateResults[currentPath];
    if (ir != null) {
      return ir as num;
    }

    final node = calculationModel.pathLUT[currentPath];
    if (node == null) {
      throw ArgumentError(
          "The reference '$path' (resolved to '$currentPath') was not found.");
    }

    num res;

    if (node is FormulaNode) {
      res = node.footprintFn(
        <T>(p) => _getInputValue<T>(p, currentPath),
        <T extends num>(p) => _getRefValue<T>(p, currentPath),
      );
    } else if (node is NestedNode) {
      final input = calculationModel.inputModel.resolvePath(node.input)
          as NestedEntityInput;
      final nestedValues =
          (_getInputValue(node.input, currentPath) as BuiltList<Object>? ??
                  BuiltList())
              .cast<NestedValues>();

      final nestedRes = nestedValues.map((item) {
        return CalculationScope(
          values: item,
          inputScope:
              input.entityTypes.singleWhere((e) => e.key == item.entity),
          rootNode: "$currentPath.${item.entity}",
          calculationModel: calculationModel,
        ).evaluate();
      });

      // !Hack!: the individual results are added here as well for the UI to
      // display them. Paths are currentPath.0, currentPath.1, ...
      nestedRes.fold<int>(0, (i, element) {
        _intermediateResults["$currentPath.$i"] = element;
        return i + 1;
      });

      res = nestedRes.isNotEmpty ? nestedRes.reduce((a, b) => a + b) : 0;
    } else {
      throw ArgumentError(
          "The reference '$path' (resolved to '$currentPath') is not a FormulaNode, but was expected to be one.");
    }

    _intermediateResults[currentPath] = res;
    return res;
  }

  T _getInputValue<T>(String path, String base) {
    final p = _normalizePath(path, base);
    final inp = calculationModel.inputModel.resolvePath(p);
    if (inp == null) {
      throw ArgumentError("The input $path (resolved to $p) was not found.");
    }

    var v = _userValues.values[p];

    if (v != null) v = inp.getNormalizedValue(v);
    v ??= inp is NestedEntityInput
        ? inp.defaultValue?.map((key) => NestedValues.empty(key)).toBuiltList()
        : inp.defaultValue;

    if (v is T) {
      return v;
    } else {
      throw ArgumentError(
          "Found a value of a different type (${v.runtimeType}) than expected ($T) for input $p in node $base.");
    }
  }

  T _getRefValue<T extends num>(String path, String base) {
    final v = _evaluatePath(path, base);

    if (v is T) {
      return v;
    } else {
      throw ArgumentError(
          "Found a value of a different type (${v.runtimeType}) than expected ($T) for reference $path ($base).");
    }
  }

  /// Resolves relative paths to its absolute path based on a base path.
  /// Supports paths starting with "." to denote searching in the nodes
  /// contained in the current node, and paths starting with ".." to
  /// search in sibling nodes to the current node.
  String _normalizePath(String path, String base) {
    if (path.startsWith("..")) {
      var i = base.lastIndexOf(".");
      if (i < 0) {
        return path.substring(2);
      } else {
        return "${base.substring(0, i)}${path.substring(1)}";
      }
    } else if (path.startsWith(".")) {
      if (base.isEmpty) {
        return path.substring(1);
      } else {
        return "$base$path";
      }
    } else {
      return path;
    }
  }
}

class CalculationScope {
  final ValueScope values;
  final InputScope inputScope;
  final String rootNode;
  final CalculationModel calculationModel;

  CalculationScope({
    required this.values,
    required this.inputScope,
    required this.rootNode,
    required this.calculationModel,
  });

  num evaluate() {
    return _evaluatePath(rootNode, "");
  }

  num _evaluatePath(String path, String base) {
    final currentPath = _normalizePath(path, base);

    final node = calculationModel.pathLUT[currentPath];
    if (node == null) {
      throw ArgumentError(
          "The reference '$path' (resolved to '$currentPath') was not found.");
    }

    num res;

    if (node is FormulaNode) {
      res = node.footprintFn(
        <T>(p) => _getInputValue<T>(p, ""),
        <T extends num>(p) => _getRefValue<T>(p, currentPath),
      );
    } else {
      throw ArgumentError(
          "The reference '$path' (resolved to '$currentPath') is not a FormulaNode, but was expected to be one.");
    }

    return res;
  }

  T _getInputValue<T>(String path, String base) {
    final p = _normalizePath(path, base);
    final inp = inputScope.resolvePath(p);
    if (inp == null) {
      throw ArgumentError("The input $path (resolved to $p) was not found.");
    }

    var v = values.values[p];

    if (v != null) v = inp.getNormalizedValue(v);
    v ??= inp.defaultValue;

    if (v is T) {
      return v;
    } else {
      throw ArgumentError(
          "Found a value of a different type (${v.runtimeType}) than expected ($T) for input $p in node $base.");
    }
  }

  T _getRefValue<T extends num>(String path, String base) {
    final v = _evaluatePath(path, base);

    if (v is T) {
      return v;
    } else {
      throw ArgumentError(
          "Found a value of a different type (${v.runtimeType}) than expected ($T) for reference $path ($base).");
    }
  }

  String _normalizePath(String path, String base) {
    if (path.startsWith("..")) {
      var i = base.lastIndexOf(".");
      if (i < 0) {
        return path.substring(2);
      } else {
        return "${base.substring(0, i)}${path.substring(1)}";
      }
    } else if (path.startsWith(".")) {
      if (base.isEmpty) {
        return path.substring(1);
      } else {
        return "$base$path";
      }
    } else {
      return path;
    }
  }
}
