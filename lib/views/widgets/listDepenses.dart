import 'package:budget/models/depense.dart';
import 'package:budget/viewmodels/viewdepense.dart';
import 'package:budget/views/widgets/transactions.dart';
import 'package:flutter/material.dart';

class Listdepenses extends StatefulWidget {
  const Listdepenses({super.key});

  @override
  State<Listdepenses> createState() => _ListdepensesState();
}

class _ListdepensesState extends State<Listdepenses> {
  final Viewdepense storage = Viewdepense();
  List<Depense> depenses = [];

  @override
  void initState() {
    super.initState();
    _chargerDepenses();
  }

  Future<void> _chargerDepenses() async {
    final donnees = await storage.getAllDepenses();
    setState(() {
      depenses = donnees;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, left: 25, right: 25),
      height: 1000,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Colors.white, // Déplacer la couleur ici
      ),
      child: Column(
        children:
            depenses.map((depense) => Transactions(depense: depense)).toList(),
      ),
    );
  }
}
