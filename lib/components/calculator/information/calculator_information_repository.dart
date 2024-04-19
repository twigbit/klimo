import 'dart:convert';

import 'package:klimo/common/repository/cached_content_repository.dart';
import 'package:klimo_datamodels/serializers.dart' as serdes;
import 'package:klimo_datamodels/calculator_information.dart';

import '../../../config/firebase.dart';

class CalculatorInformationRepository
    extends CachedContentRepository<CalculatorInformationResponse> {
  CalculatorInformationRepository(this.language);

  final String language;

  @override
  String get url =>
      httpFunctions
      .getFunctionUrl("fetchCalculatorInformation", {"language": language});

  @override
  CalculatorInformationResponse deserialize(String content) {
    return serdes
        .deserialize<CalculatorInformationResponse>(jsonDecode(content))!;
  }
}
