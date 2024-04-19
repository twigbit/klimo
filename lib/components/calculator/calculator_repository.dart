import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klimo/utils/iterable.dart';
import 'package:klimo/config/firebase.dart';
import 'package:klimo_datamodels/calculation_engine.dart';

class CalculatorRepository {
  final String userId;

  CalculatorRepository(this.userId);

  CollectionReference<CalculationSnapshot> get userCalculationCollection => fb
      .userCollection()
      .doc(userId)
      .calculationCollection<CalculationSnapshot>();

  Query<CalculationSnapshot> get lastUserCalculation =>
      userCalculationCollection.orderBy("updatedAt", descending: true).limit(1);

  Future<CalculationSnapshot?> currentCalculationSnapshot() async {
    final res = await lastUserCalculation
        .orderBy("updatedAt", descending: true)
        .limit(1)
        .get();

    return res.docs.safeFirst?.data();
  }

  Future<void> saveCalculationSnapshot(CalculationSnapshot snapshot) async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    await userCalculationCollection.doc(id).set(snapshot);
  }
}
