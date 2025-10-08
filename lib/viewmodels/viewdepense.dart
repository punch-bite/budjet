
import 'package:budget/models/depense.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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

  Future<List<Depense>> getAllDepensesWithLimit(int n) async {
    return getAllDepenses().take(n).toList();
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
        'depenseCeMois': {},
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

    // Dépenses du mois par type
    final depensesMoisParType = <String, double>{};
    for (final depense in depensesCeMois) {
      final montant = double.parse(depense.montant);
      depensesMoisParType[depense.type] =
          (depensesMoisParType[depense.type] ?? 0) + montant;
    }

    return {
      'total': total,
      'moyenne': total / depenses.length,
      'nombre': depenses.length,
      'parType': depensesParType,
      'dernierMois': totalMois,
      'depenseCeMois': depensesMoisParType,
    };
  }

  // FILTRES
  List<Depense> getDepensesByType(String type) {
    return getAllDepenses().where((depense) => depense.type == type).toList();
  }

  // FILTRES
  Map<DateTime, double> getDepenseStatsByType(String type) {
    List<Depense> depensesStats =
        getAllDepenses().where((depense) => depense.type == type).toList();
    Map<DateTime, double> depensesDate = {};

    for (var depense in depensesStats) {
      DateTime jour = DateTime(
        depense.created_at.year,
        depense.created_at.month,
        depense.created_at.day,
      );
      double som = 0;
      for (int i = 0; i < depensesStats.length; i++) {
        DateTime jours = DateTime(
          depensesStats[i].created_at.year,
          depensesStats[i].created_at.month,
          depensesStats[i].created_at.day,
        );
        if (jour.day == jours.day) {
          som = som + double.parse(depensesStats[i].montant);
          // depenses.add(som);
        }
      }
      depensesDate.putIfAbsent(jour, som as double Function());
    }

    return depensesDate;
  }

  List<Depense> getDepensesByDateRange(
    String type,
    DateTime start,
    DateTime end,
  ) {
    return getAllDepenses().where((depense) {
      return depense.type.contains(type) &&
          depense.created_at.isAfter(start) &&
          depense.created_at.isBefore(end);
    }).toList();
  }

  Future<Map<DateTime, List<Depense>>> getDepensesGroupesParJour({
    double? montantMinimum,
  }) async {
    // 1. Ouvrir la boîte Hive
    final depenseBox = getAllDepenses();

    // 2. Récupérer toutes les valeurs et les caster en List<Depense>
    Iterable<Depense> toutesDepenses = depenseBox.cast<Depense>();

    // 3. Filtrer par montant si un critère est donné
    if (montantMinimum != null) {
      toutesDepenses = toutesDepenses.where((depense) {
        // Convertir le montant (String) en double pour comparaison
        final montant = double.tryParse(depense.montant) ?? 0.0;
        return montant >= montantMinimum;
      });
    }

    // 4. Grouper par date (en ignorant l'heure)
    Map<DateTime, List<Depense>> depensesParJour = {};

    for (final depense in toutesDepenses) {
      // Convertir le DateTime en jour seulement (à 00:00:00)
      final jour = DateTime(
        depense.created_at.year,
        depense.created_at.month,
        depense.created_at.day,
      );

      // Ajouter la dépense au groupe correspondant à sa journée
      depensesParJour.putIfAbsent(jour, () => []).add(depense);
    }

    // 5. Fermer la boîte (optionnel, si vous n'en avez plus besoin)
    // await depenseBox.close();

    return depensesParJour;
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
        backgroundColor:
            statut == 'success'
                ? Colors.greenAccent[700]
                : Colors.redAccent[700],
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(5)),
        // ...
      ),
    );
  }

  // Utilisation
  // showQuickMessage('Action terminée');
}
