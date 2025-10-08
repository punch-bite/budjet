import 'package:budget/models/depense.dart';
import 'package:budget/viewmodels/viewdepense.dart';
import 'package:budget/views/widgets/dashboard.dart';
import 'package:budget/views/widgets/header.dart';
import 'package:budget/views/widgets/listDepenses.dart';
import 'package:budget/views/widgets/menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Viewdepense viewdepense = Viewdepense();
  List<Depense> depenses = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _depenses();
  }

  Future<void> _depenses() async {
    setState(() {
      _isLoading = true;
    });

    // Simuler un délai de chargement pour une meilleure UX
    await Future.delayed(const Duration(milliseconds: 1000));

    final donnees = await viewdepense.getAllDepensesWithLimit(10);
    setState(() {
      depenses = donnees;
      _isLoading = false;
    });
  }

  // ... Autres imports et code de la classe HomePage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 90, 0, 192),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Header(),
            Dashboard(),
            // Gestion améliorée de l'état de chargement
            if (_isLoading)
              AnimatedContainer(
                // Correction de la durée
                duration: Duration(milliseconds: 1000),
                // Suppression du widget Positioned inutile
                child: Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    gradient: LinearGradient(
                      colors: [Colors.deepPurpleAccent, Colors.deepPurple],
                      // Définition de la direction du gradient (recommandé)
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Chargement...",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Listdepenses(
                depensers: depenses,
                emptyMessage:
                    depenses.isEmpty
                        ? 'Aucune transaction pour le moment!'
                        : '',
              ),
          ],
        ),
      ),
      bottomNavigationBar: Menu(),
    );
  }
}
