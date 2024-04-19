import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klimo/config/firebase_http_functions.dart';
import 'package:klimo_datamodels/challenges.dart';
import 'package:klimo_datamodels/serializers.dart';
import 'package:klimo_datamodels/user.dart';

FirebaseApp firebase = Firebase.app();
FirebaseFirestore get firestore => FirebaseFirestore.instanceFor(app: firebase);
DocumentReference get fb => firestore.root;
FirebaseAnalytics get analytics => FirebaseAnalytics.instance;
FirebaseAuth get auth => FirebaseAuth.instanceFor(app: firebase);
FirebaseDynamicLinks get links => FirebaseDynamicLinks.instance;
FirebaseCrashlytics get crashlytics => FirebaseCrashlytics.instance;
FirebaseStorage get storage => FirebaseStorage.instanceFor(app: firebase);
FirebaseHttpFunctions get httpFunctions =>
    FirebaseHttpFunctions.instanceFor(app: firebase);
FirebaseMessaging get messaging => FirebaseMessaging.instance;

extension TypedCollection on CollectionReference {
  CollectionReference<T> typed<T>() {
    return withConverter<T>(fromFirestore: (snapshot, _) {
      Serializer? serializer = serializers.serializerForType(T);
      if (serializer == null) throw ("No Serializer defined for type $T");
      return serializers.deserializeWith(
        serializer,
        {...?snapshot.data(), 'id': snapshot.id},
      );
    }, toFirestore: (T value, _) {
      Serializer? serializer = serializers.serializerForType(T);
      if (serializer == null) throw ("No Serializer defined for type $T");
      return serializers.serializeWith(serializer, value)
          as Map<String, Object?>;
    });
  }
}

extension WithUserDoc on CollectionReference {
  DocumentReference? userDoc() =>
      auth.currentUser != null ? doc(auth.currentUser!.uid) : null;
}

extension WithCustomCollection on FirebaseFirestore {
  DocumentReference get root => doc('/');

  // TODO move to docs gracefully
  CollectionReference get userCollection => collection('users');
  CollectionReference get usernamesCollection => collection('usernames');
  CollectionReference get challengeCollection =>
      collection('challenges').typed<Challenge>();
  CollectionReference get userChallengeCollection =>
      userDocument.collection('challenges');
  CollectionReference get userChallengeCollectionTyped =>
      userChallengeCollection.typed<Challenge>();
  DocumentReference get userDocument =>
      userCollection.doc(auth.currentUser!.uid);
  CollectionReference get profileCollection =>
      collection('users').typed<ProfileModel>();
}

extension WithCustomCollections on DocumentReference {
  CollectionReference<T> _collection<T>(String key) =>
      collection(key).typed<T>();

  CollectionReference<T> communityCollection<T>() => _collection('communities');
  CollectionReference<T> departmentsCollection<T>() =>
      _collection('departments');
  CollectionReference<T> userCollection<T>() => _collection('users');
  CollectionReference<T> teamsCollection<T>() => _collection('teams');
  CollectionReference<T> consentCollection<T>() => _collection('consent');
  CollectionReference<T> challengeCollection<T>() => _collection('challenges');
  CollectionReference<T> initiativeCollection<T>() =>
      _collection('initiatives');
  CollectionReference<T> deletionRequestCollection<T>() =>
      _collection('deletionRequests');
  CollectionReference<T> calculationCollection<T>() =>
      _collection('calculations');
  CollectionReference<T> offsetCollection<T>() => _collection('offset');
  CollectionReference<T> adventCalendarCollection<T>() =>
      _collection('adventCalendar');

  DocumentReference<T> type<T>() => parent.typed<T>().doc(id);
}

extension WithCustomMethods<T> on DocumentReference<T> {
  Future<void> upset(T data) => set(data, SetOptions(merge: true));
}

extension WithCustomSet on WriteBatch {
  void upset<T>(DocumentReference<T> document, T data, [SetOptions? options]) =>
      set<T>(document, data, options ?? SetOptions(merge: true));
}

extension WithSerializers on Serializers {
  Serializer<T>? serializerByType<T>() =>
      serializerForType(T) as Serializer<T>?;
}

mixin ErrorHandling<T> on BlocBase<T> {
  @override
  void onError(error, stackTrace) {
    debugPrint(error.toString());
    debugPrint(stackTrace.toString());
    if (!kIsWeb) crashlytics.recordError(error, stackTrace);
    super.onError(error, stackTrace);
  }
}
