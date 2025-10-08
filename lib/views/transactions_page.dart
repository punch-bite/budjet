import 'package:budget/models/depense.dart';
import 'package:budget/viewmodels/viewdepense.dart';
import 'package:budget/views/depense_form.dart';
import 'package:budget/views/widgets/listDepenses.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  List<Depense> depenses = [];
  final Viewdepense depenseview = Viewdepense();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  DateTimeRange? selectedDateRange;
  String? _selectedValue;
  bool _isLoading = false;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _loadDepenses();
  }

  Future<void> _loadDepenses() async {
    setState(() {
      _isLoading = true;
    });

    // Simuler un délai de chargement pour une meilleure UX
    await Future.delayed(const Duration(milliseconds: 500));

    final donnees = depenseview.getAllDepenses();
    setState(() {
      depenses = donnees;
      _isLoading = false;
    });
  }

  Future<void> _showDateRangePicker() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 20),
      lastDate: DateTime(DateTime.now().year + 20),
      initialDateRange: selectedDateRange,
      helpText: 'Sélectionnez une plage de dates',
      saveText: 'Valider',
    );

    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  String getDateRangeText() {
    if (selectedDateRange == null) {
      return 'Période';
    }
    final start = selectedDateRange!.start.toString().split(' ')[0];
    final end = selectedDateRange!.end.toString().split(' ')[0];
    return '$start - $end';
  }

  void _resetSearch() {
    setState(() {
      _selectedValue = null;
      selectedDateRange = null;
      _hasSearched = false;
      _searchController.clear();
    });
    _loadDepenses();
  }

  Future<void> submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (selectedDateRange != null && _selectedValue != null) {
        setState(() {
          _isLoading = true;
          _hasSearched = true;
        });

        // Simuler un délai de recherche
        await Future.delayed(const Duration(milliseconds: 300));

        final String searchTerm = _selectedValue!;
        List<Depense> filteredList = depenseview.getDepensesByDateRange(
          searchTerm,
          selectedDateRange!.start,
          selectedDateRange!.end,
        );

        setState(() {
          depenses = filteredList;
          _isLoading = false;
        });

        _focusNode.unfocus();
      } else {
        String message = '';
        if (selectedDateRange == null && _selectedValue == null) {
          message =
              'Veuillez sélectionner une période et un type de transaction';
        } else if (selectedDateRange == null) {
          message = 'Veuillez sélectionner une plage de dates';
        } else {
          message = 'Veuillez sélectionner un type de transaction';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 10),
        primary: true,
        title: const Text("Transactions"),
        backgroundColor: Colors.deepPurpleAccent[700],
        elevation: 0,
        foregroundColor: Colors.white,
        actions: [
          if (_hasSearched)
            IconButton(
              onPressed: _resetSearch,
              icon: const Icon(Icons.refresh),
              tooltip: 'Réinitialiser la recherche',
            ),
          IconButton(
            // style: ButtonStyle(
            //   ma
            // ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DepenseForm()),
              );
            },
            icon: const Icon(Icons.add_outlined, color: Colors.white),
            tooltip: "Nouvelle transaction",
          ),
        ],
      ),
      backgroundColor: Colors.deepPurpleAccent[700],
      body: Column(
        children: [
          // Formulaire de recherche amélioré
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.3),
              //     spreadRadius: 1,
              //     blurRadius: 10,
              //     offset: const Offset(0, 5),
              //   ),
              // ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // En-tête avec informations de recherche
                  if (selectedDateRange != null || _selectedValue != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          if (selectedDateRange != null) ...[
                            const Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Colors.deepPurple,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              getDateRangeText(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepPurple,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                          if (_selectedValue != null) ...[
                            const Icon(
                              Icons.category,
                              size: 16,
                              color: Colors.deepPurple,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _selectedValue!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ],
                          const Spacer(),
                          if (_hasSearched)
                            GestureDetector(
                              onTap: _resetSearch,
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.grey,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],

                  // Row de recherche
                  Row(
                    children: [
                      // Dropdown amélioré
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: Colors.grey[50],
                            filled: true,
                            labelText: "Type de transaction",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            prefixIcon: const Icon(
                              Icons.category_outlined,
                              color: Colors.deepPurple,
                            ),
                          ),
                          value: _selectedValue,
                          hint: const Text(
                            'Sélectionnez un type',
                            style: TextStyle(color: Colors.grey, fontSize: 9),
                          ),
                          items:
                              <String>['Dépense', 'Gain'].map((String option) {
                                return DropdownMenuItem<String>(
                                  value: option,
                                  child: Text(
                                    option,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedValue = newValue;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Veuillez sélectionner une option";
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Bouton calendrier avec indicateur
                      Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          color:
                              selectedDateRange != null
                                  ? Colors.deepPurpleAccent.withOpacity(0.2)
                                  : Colors.deepPurpleAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                          border:
                              selectedDateRange != null
                                  ? Border.all(color: Colors.deepPurpleAccent)
                                  : null,
                        ),
                        child: IconButton(
                          onPressed: _showDateRangePicker,
                          icon: Icon(
                            Icons.calendar_month,
                            size: 26,
                            color: Colors.deepPurpleAccent[700],
                          ),
                          tooltip: 'Choisir une période',
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Bouton recherche avec loading
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurpleAccent[700]!,
                              Colors.purpleAccent[400]!,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurpleAccent.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child:
                            _isLoading
                                ? const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : IconButton(
                                  onPressed: submitForm,
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  tooltip: 'Lancer la recherche',
                                ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Indicateur de chargement ou résultats
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child:
                  _isLoading
                      ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Chargement...',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                      : Container(
                        key: ValueKey(depenses.length),
                        child: Column(
                          children: [
                            // En-tête des résultats
                            if (_hasSearched && depenses.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '${depenses.length} résultat(s) trouvé(s)',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton.icon(
                                      onPressed: _resetSearch,
                                      icon: const Icon(
                                        Icons.clear_all,
                                        color: Colors.white70,
                                        size: 16,
                                      ),
                                      label: const Text(
                                        'Tout afficher',
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Liste des dépenses
                            Expanded(
                              child: Listdepenses(
                                depensers: depenses.isNotEmpty ? depenses : [],
                                emptyMessage:
                                    _hasSearched
                                        ? 'Aucun résultat trouvé pour votre recherche'
                                        : 'Aucune transaction disponible',
                              ),
                            ),
                          ],
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
