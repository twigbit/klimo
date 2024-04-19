import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'calculator_information.g.dart';

/// The response model of the firebase callable function.
/// This type is tied to the `CalculatorInformationResponse` interface in
/// firebase/functions/src/proxies/calculator-information.ts
abstract class CalculatorInformationResponse
    implements
        Built<CalculatorInformationResponse,
            CalculatorInformationResponseBuilder> {
  BuiltList<CalculatorInformationRecord> get calculatorInformation;

  @memoized
  BuiltMap<String, CalculatorInformationRecord> get byKey =>
      BuiltMap({for (var rec in calculatorInformation) rec.key: rec});

  CalculatorInformationResponse._();

  factory CalculatorInformationResponse(
          [void Function(CalculatorInformationResponseBuilder)? updates]) =
      _$CalculatorInformationResponse;

  static Serializer<CalculatorInformationResponse> get serializer =>
      _$calculatorInformationResponseSerializer;
}

abstract class CalculatorInformationRecord
    implements
        Built<CalculatorInformationRecord, CalculatorInformationRecordBuilder> {
  /// The Airtable id of the information record
  @BuiltValueField(wireName: "_id")
  String get id;

  /// The key of the input this record belongs to
  String get key;

  /// The language code (in uppercase) the content of this record is written in
  String get language;

  /// Markdown formatted content of this record
  String get content;

  CalculatorInformationRecord._();

  factory CalculatorInformationRecord(
          [void Function(CalculatorInformationRecordBuilder)? updates]) =
      _$CalculatorInformationRecord;

  static Serializer<CalculatorInformationRecord> get serializer =>
      _$calculatorInformationRecordSerializer;
}
