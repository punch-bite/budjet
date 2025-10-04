// import 'dart:convert';

// import 'package:budget/models/depense.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // static const String _depenseKey = 'depenses'; // Clé de stockage

  // // Sauvegarde une liste de dépenses
  // Future<void> saveDepenses(List<Depense> depenses) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // Convertit la liste d'objets en liste de maps, puis en liste de chaînes JSON
  //   List<String> jsonList = depenses.map((depense) => jsonEncode(depense.toJson())).toList();
  //   // Sauvegarde la liste de chaînes
  //   await prefs.setStringList(_depenseKey, jsonList);
  // }

  // // Charge une liste de dépenses
  // Future<List<Depense>> loadDepenses() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // Récupère la liste de chaînes (peut être nulle)
  //   List<String>? jsonList = prefs.getStringList(_depenseKey);

  //   if (jsonList == null) {
  //     return []; // Retourne une liste vide si aucune donnée n'existe
  //   }

  //   // Convertit la liste de chaînes en liste d'objets Depense
  //   return jsonList.map((jsonString) => Depense.fromJson(jsonDecode(jsonString))).toList();
  // }
}