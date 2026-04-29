// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

Future<dynamic> detectDuplicateTransactionsCustom() async {
  try {
    final userRef = currentUserReference;
    if (userRef == null) {
      return {
        "success": false,
        "error": "User not authenticated",
      };
    }

    final snapshot = await FirebaseFirestore.instance
        .collection('documents')
        .where('userRef', isEqualTo: userRef)
        .where('isRemoved', isEqualTo: false)
        .where('duplicateResolved', isEqualTo: false)
        .get();

    final docs = snapshot.docs;
    final List<Map<String, dynamic>> duplicateGroups = [];
    final Set<String> processedPairs = {};

    String normalizeText(dynamic value) {
      return (value ?? '')
          .toString()
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9\s]'), ' ')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
    }

    DateTime? asDate(dynamic value) {
      if (value is Timestamp) return value.toDate();
      if (value is DateTime) return value;
      return null;
    }

    bool sameDay(DateTime? a, DateTime? b) {
      if (a == null || b == null) return false;
      return a.year == b.year && a.month == b.month && a.day == b.day;
    }

    bool similarDescription(String a, String b) {
      if (a.isEmpty || b.isEmpty) return false;
      return a == b || a.contains(b) || b.contains(a);
    }

    for (int i = 0; i < docs.length; i++) {
      final aDoc = docs[i];
      final a = aDoc.data();

      for (int j = i + 1; j < docs.length; j++) {
        final bDoc = docs[j];
        final b = bDoc.data();

        final aSource = (a['source'] ?? '').toString();
        final bSource = (b['source'] ?? '').toString();

        // Solo comparar manual vs plaid
        if (aSource == bSource) continue;
        if (!((aSource == 'plaid' && bSource != 'plaid') ||
            (bSource == 'plaid' && aSource != 'plaid'))) {
          continue;
        }

        final pairKey = [aDoc.id, bDoc.id]..sort();
        final joinedKey = pairKey.join('__');
        if (processedPairs.contains(joinedKey)) continue;

        final amountA = (a['amount'] ?? 0).toDouble();
        final amountB = (b['amount'] ?? 0).toDouble();
        final sameAmount = (amountA - amountB).abs() < 0.01;

        final sameLogic = (a['isIncome'] == b['isIncome']) &&
            (a['isExpenses'] == b['isExpenses']) &&
            (a['isSave'] == b['isSave']);

        final descA = normalizeText(a['description']);
        final descB = normalizeText(b['description']);
        final descMatch = similarDescription(descA, descB);

        final dateA = asDate(a['date']);
        final dateB = asDate(b['date']);
        final dayMatch = sameDay(dateA, dateB);

        if (sameAmount && sameLogic && descMatch && dayMatch) {
          final groupId = 'dup_${aDoc.id}_${bDoc.id}';

          await aDoc.reference.set({
            'isDuplicateCandidate': true,
            'duplicateGroupId': groupId,
          }, SetOptions(merge: true));

          await bDoc.reference.set({
            'isDuplicateCandidate': true,
            'duplicateGroupId': groupId,
          }, SetOptions(merge: true));

          duplicateGroups.add({
            'groupId': groupId,
            'docAId': aDoc.id,
            'docBId': bDoc.id,
            'sourceA': aSource,
            'sourceB': bSource,
            'descriptionA': a['description'] ?? '',
            'descriptionB': b['description'] ?? '',
            'amountA': amountA,
            'amountB': amountB,
            'dateA': dateA?.toIso8601String(),
            'dateB': dateB?.toIso8601String(),
          });

          processedPairs.add(joinedKey);
        }
      }
    }

    return {
      "success": true,
      "duplicatesFound": duplicateGroups.length,
      "groups": duplicateGroups,
    };
  } catch (e) {
    return {
      "success": false,
      "error": e.toString(),
    };
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
