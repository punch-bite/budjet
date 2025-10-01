import 'package:budget/models/depense.dart' show Depense;
import 'package:flutter/material.dart';
import 'package:budget/views/widgets/transactions.dart';

class Listdepenses extends StatelessWidget {
  final List<Depense> depenses;

  Listdepenses({super.key}) : 
    depenses = [
      Depense(id: '1', name: 'Market', montant: '1 600', created_at: DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year)),
      Depense(id: '2', name: 'Transport', montant: '1 500', created_at: DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year)),
      Depense(id: '3', name: 'Shopping', montant: '18 800', created_at: DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year)),
      Depense(id: '4', name: 'Voyage', montant: '10 800', created_at: DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year)),
      Depense(id: '5', name: 'Market', montant: '28 800', created_at: DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year)),
      Depense(id: '6', name: 'Food', montant: '11 800', created_at: DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year)),
      Depense(id: '7', name: 'Shopping', montant: '14 500', created_at: DateTime(DateTime.now().day, DateTime.now().month, DateTime.now().year)),
    ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(top: 50, left: 25, right: 25),
      height: 1000,
      margin: const EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Colors.white, // Déplacer la couleur ici
        
      ),
      child: Column(
        children: depenses.map((depense) => Transactions(depense: depense)).toList(),
      ),
    );
  }
}