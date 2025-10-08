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

  bool _isNumeric(String value) {
    return double.tryParse(value) != null;
  }

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
      depenses.notifyMe(
        "success",
        "Transaction effectuées avec succès!",
        context,
      );

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

    // print('type : ${_montantController.text}');
    // dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[700],

      appBar: AppBar(
        title: Text(
          "Nouvelle transaction",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurpleAccent[700],
        foregroundColor: Colors.white,
      ),
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
                    fillColor: Colors.deepPurple[700],
                    filled: true,
                    hintText: "Transaction",
                    hintStyle: TextStyle(
                      backgroundColor: Colors.deepPurple[700],
                      color: const Color.fromARGB(178, 255, 255, 255),
                      fontSize: 12,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                    labelText: "Type de transaction",
                    labelStyle: TextStyle(
                      backgroundColor: Colors.deepPurple[700],
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Colors.deepPurple,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.refresh_outlined,
                      color: const Color.fromARGB(179, 255, 255, 255),
                    ),
                  ),
                  // Allow the value to be null and provide a hint
                  value: _selectedValue,
                  // Hint when no value is selected
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
                    labelStyle: TextStyle(
                      backgroundColor: Colors.deepPurple[700],
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      
                    ),
                    fillColor: Colors.deepPurple[700],
                    filled: true,
                    hintText: "Dépense du jour?",
                    hintStyle: TextStyle(
                      backgroundColor: Colors.deepPurple[700],
                      color: const Color.fromARGB(160, 255, 255, 255),
                      fontSize: 12,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.deepPurpleAccent,
                      ),
                    ),
                    prefixIcon: Icon(Icons.shopping_bag, color: const Color.fromARGB(178, 255, 255, 255)),
                    focusColor: Colors.deepPurple,
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
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Montant",
                    labelStyle: TextStyle(
                      backgroundColor: Colors.deepPurple[700],
                      fontFamily: "Poppins",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    hintText: "Dans quoi avez dépensé?",
                    suffixText: "FCFA",
                    suffixStyle: TextStyle(color: const Color.fromARGB(195, 255, 255, 255)),
                    hintStyle: TextStyle(
                      backgroundColor: Colors.deepPurple[700],
                      color: const Color.fromARGB(186, 255, 255, 255),
                      fontSize: 12,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                    ),
                    fillColor: Colors.deepPurple[700],
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Colors.deepPurple,
                      ),
                    ),
                    prefixIcon: Icon(Icons.euro_outlined, color: const Color.fromARGB(174, 255, 255, 255)),
                    focusColor: const Color.fromARGB(40, 196, 175, 255),
                  ),

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Champ est vide";
                    }
                    if (!_isNumeric(value)) {
                      return "Vous devez entrer une valeur numérique!";
                    }
                    if (double.parse(value) <= 0) {
                      return 'Le montant doit être positif';
                    }

                    return null;
                  },
                ),

                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.deepPurple, Colors.purple],
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child:
                      _isLoading
                          ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.0,
                            ),
                          )
                          : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              minimumSize: Size(
                                MediaQuery.of(context).size.width,
                                56,
                              ),
                              elevation: 10,
                              // textStyle: TextStyle(color: Colors.white),
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
                              // style: TextStyle(color: Colors.white),
                            ),
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
