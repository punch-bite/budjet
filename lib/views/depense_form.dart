// ignore_for_file: unnecessary_string_interpolations

import 'package:budget/models/depense.dart';
import 'package:budget/viewmodels/viewdepense.dart';
import 'package:flutter/material.dart';

class DepenseForm extends StatefulWidget {
  const DepenseForm({super.key});

  @override
  State<DepenseForm> createState() => _DepenseFormState();
}

class _DepenseFormState extends State<DepenseForm> {
  final _formKey = GlobalKey<FormState>();
  final Viewdepense depenses = Viewdepense();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _montantController = TextEditingController();
  // TextEditingController _typeController = TextEditingController();
  // final FocusNode _focusNode = FocusNode();

  String? _selectedValue;
  bool _isLoading = false;

  Future<void> insertDepense(Depense depense) async {
    if (!_formKey.currentState!.validate()) return;

    // Vérifier spécifiquement _selectedValue
    if (_selectedValue == null || _selectedValue!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Veuillez sélectionner un type de transaction"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await depenses.addDepense(depense);
      depenses.notifyMe("success", "Transaction effectuées avec succès!", context);

      // Vider les champs après succès
      _nameController.clear();
      _montantController.clear();
      _selectedValue = null;
    } on Exception catch (e) {
      // TODO
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Erreur: ${e.toString()}"),
          backgroundColor: Colors.redAccent[500],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }

    print('type : ${_montantController.text}');
    // dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nouvelle transaction")),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(20, 124, 77, 255),
                    filled: true,
                    hintText: "Sélectionnez une transaction",
                    labelText: "Type de transaction",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.refresh_outlined),
                  ),
                  // Allow the value to be null and provide a hint
                  value: _selectedValue,
                  hint: Text(
                    'Sélectionnez une transaction',
                  ), // Hint when no value is selected
                  items:
                      <String>['Dépense', 'Gain'].map((String option) {
                        return DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue; // Can be null
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez sélectionner une option";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 15),
                TextFormField(
                  controller: _nameController,
                  // focusNode: _focusNode,
                  decoration: InputDecoration(
                    labelText: "Sujet de la depense",
                    fillColor: const Color.fromARGB(20, 124, 77, 255),
                    filled: true,
                    hintText: "Dans quoi avez dépensé aujourd'hui?",
                    hintStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    prefixIcon: Icon(Icons.shopping_bag),
                    focusColor: const Color.fromARGB(40, 196, 175, 255),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Champ est vide";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 15),
                TextFormField(
                  controller: _montantController,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    labelText: "Montant",
                    hintText: "Dans quoi avez dépensé?",

                    fillColor: const Color.fromARGB(20, 124, 77, 255),
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    prefixIcon: Icon(Icons.euro_outlined),
                    focusColor: const Color.fromARGB(40, 196, 175, 255),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Champ est vide";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 15),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurpleAccent[700],
                      foregroundColor: const Color.fromARGB(255, 88, 88, 88),
                      minimumSize: Size(MediaQuery.of(context).size.width, 40),
                      elevation: 10,
                      textStyle: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Depense depense = Depense(
                        type:
                            _selectedValue!, // Using ! because validator ensures it's not null
                        name: _nameController.text,
                        montant: _montantController.text,
                        created_at: DateTime.now(),
                      );
                      insertDepense(depense);
                    },
                    child: Text(
                      "Enregistrer",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _montantController.dispose();
    // _focusNode.dispose();
    super.dispose();
  }
}
