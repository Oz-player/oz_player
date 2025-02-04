

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oz_player/data/source/login/revoke_reason_data_source.dart';

class RevokeReasonDataSourceImpl implements RevokeReasonDataSource {
  final FirebaseFirestore _firestore;

  RevokeReasonDataSourceImpl(this._firestore);

  @override
  Future<void> updateRevokeReason(String reason) async {
    final docRef = _firestore.collection('Revoke').doc('reason');

    await _firestore.runTransaction((transaction) async {
      final docSnapshot = await transaction.get(docRef);

      if (!docSnapshot.exists) return;

      final data = docSnapshot.data() as Map<String, dynamic>;
      final updatedCount = (data[reason] ?? 0) + 1;

      transaction.update(docRef, {reason: updatedCount});
    });
  }
}