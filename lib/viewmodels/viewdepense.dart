import 'package:budget/models/depense.dart';
import 'package:flutter/foundation.dart';

class Viewdepense with ChangeNotifier {
  final List<Depense> _depenses = [];

  List<Depense> get depenses => _depenses;

  void addDpense(String depense, String amount) {
    final newDepense = Depense(
      id: DateTime.now().toString(),
      name: depense,
      montant: amount,
      created_at: DateTime.now(),
    );

    _depenses.add(newDepense);

    notifyListeners();
  }

  void toggleDepense(String id) {
    final index = _depenses.indexWhere((spend) => spend.id == id);
    if (index != -1) {
      _depenses[index] = _depenses[index].copyWith(
        montant: _depenses[index].montant,
      );
    }
    notifyListeners();
  }

  void deleteDepense(String id) {
    _depenses.removeWhere((spend) => spend.id == id);
    notifyListeners();
  }
}
