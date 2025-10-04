import 'package:budget/models/depense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;

class Viewdepense {
  static final Viewdepense _instance = Viewdepense._internal();
  factory Viewdepense() => _instance;
  Viewdepense._internal();

  Box<Depense> get depenseBox => Hive.box<Depense>('depensesBox');

  // CREATE - Ajouter une dépense
  Future<void> addDepense(Depense depense) async {
    await depenseBox.add(depense);
  }

  // READ - Obtenir toutes les dépenses
  List<Depense> getAllDepenses() {
    return depenseBox.values.toList();
  }

  // READ - Obtenir une dépense par index
  Depense? getDepenseAt(int index) {
    if (index >= 0 && index < depenseBox.length) {
      return depenseBox.getAt(index);
    }
    return null;
  }

  // UPDATE - Modifier une dépense
  Future<void> updateDepense(int index, Depense newDepense) async {
    if (index >= 0 && index < depenseBox.length) {
      await depenseBox.putAt(index, newDepense);
    }
  }

  // DELETE - Supprimer une dépense
  Future<void> deleteDepense(int index) async {
    if (index >= 0 && index < depenseBox.length) {
      await depenseBox.deleteAt(index);
    }
  }

  // DELETE ALL - Supprimer toutes les dépenses
  Future<void> clearAllDepenses() async {
    await depenseBox.clear();
  }

  // STATISTIQUES
  Map<String, dynamic> getStatistics() {
    final depenses = getAllDepenses();

    if (depenses.isEmpty) {
      return {
        'total': 0,
        'moyenne': 0,
        'nombre': 0,
        'parType': {},
        'dernierMois': 0,
      };
    }

    // Total des dépenses
    final total = depenses.fold<double>(0, (sum, depense) {
      return sum + double.parse(depense.montant);
    });

    // Dépenses par type
    final depensesParType = <String, double>{};
    for (final depense in depenses) {
      final montant = double.parse(depense.montant);
      depensesParType[depense.type] =
          (depensesParType[depense.type] ?? 0) + montant;
    }

    // Dépenses du dernier mois
    final maintenant = DateTime.now();
    final premierJourMois = DateTime(maintenant.year, maintenant.month, 1);
    final depensesCeMois =
        depenses.where((depense) {
          return depense.created_at.isAfter(premierJourMois);
        }).toList();

    final totalMois = depensesCeMois.fold<double>(0, (sum, depense) {
      return sum + double.parse(depense.montant);
    });

    return {
      'total': total,
      'moyenne': total / depenses.length,
      'nombre': depenses.length,
      'parType': depensesParType,
      'dernierMois': totalMois,
    };
  }

  // FILTRES
  List<Depense> getDepensesByType(String type) {
    return getAllDepenses().where((depense) => depense.type == type).toList();
  }

  List<Depense> getDepensesByDateRange(DateTime start, DateTime end) {
    return getAllDepenses().where((depense) {
      return depense.created_at.isAfter(start) &&
          depense.created_at.isBefore(end);
    }).toList();
  }

  // Pour un message rapide
  // The parameter must be explicitly typed as BuildContext
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> notifyMe(
    String statut,
    String message,
    BuildContext context, // Make sure this is BuildContext
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      // ... and here
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 4),
        backgroundColor: statut == 'success' ? Colors.greenAccent[700] : Colors.redAccent[700],
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(25)),
        // ...
      ),
    );
  }

  // Utilisation
  // showQuickMessage('Action terminée');
}
