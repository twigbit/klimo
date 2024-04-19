import 'package:built_collection/built_collection.dart';
export 'package:built_collection/built_collection.dart'
    show BuiltMap, MapBuilder;

extension LocalisationUtil on String {
  MapBuilder<String, String> translationBuilder() =>
      MapBuilder<String, String>()..addEntries([MapEntry('de', this)]);
}

typedef Translation<T> = BuiltMap<String, T>;
