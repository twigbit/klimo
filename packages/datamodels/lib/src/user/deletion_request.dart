import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'deletion_request.g.dart';

class DeletionRequestStatus extends EnumClass {
  static const DeletionRequestStatus pending = _$pending;
  static const DeletionRequestStatus processed = _$processed;
  static const DeletionRequestStatus revoked = _$revoked;

  const DeletionRequestStatus._(String name) : super(name);
  static BuiltSet<DeletionRequestStatus> get values => _$values;
  static DeletionRequestStatus valueOf(String name) => _$valueOf(name);
  static Serializer<DeletionRequestStatus> get serializer =>
      _$deletionRequestStatusSerializer;
}

abstract class DeletionRequestBase {
  Object? get timestamp;
  DocumentReference? get userRef;
  DeletionRequestStatus? get status;
  Object? get revokedAt;
}

abstract class DeletionRequest
    implements
        Built<DeletionRequest, DeletionRequestBuilder>,
        DeletionRequestBase {
  @override
  DateTime get timestamp;

  @override
  DocumentReference get userRef;

  @override
  DeletionRequestStatus get status;

  @override
  DateTime? get revokedAt;

  DeletionRequest._();
  factory DeletionRequest([void Function(DeletionRequestBuilder) updates]) =
      _$DeletionRequest;

  static Serializer<DeletionRequest> get serializer =>
      _$deletionRequestSerializer;
}

abstract class DeletionRequestUpdate
    implements
        Built<DeletionRequestUpdate, DeletionRequestUpdateBuilder>,
        DeletionRequestBase {
  DeletionRequestUpdate._();
  factory DeletionRequestUpdate(
          [void Function(DeletionRequestUpdateBuilder) updates]) =
      _$DeletionRequestUpdate;

  @override
  FieldValue? get timestamp;

  @override
  FieldValue? get revokedAt;

  @BuiltValueHook(initializeBuilder: true)
  static void _setDefaults(DeletionRequestUpdateBuilder b) =>
      b..status = DeletionRequestStatus.pending;

  static Serializer<DeletionRequestUpdate> get serializer =>
      _$deletionRequestUpdateSerializer;
}
