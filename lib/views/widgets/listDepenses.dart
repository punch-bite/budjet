import 'package:budget/models/depense.dart';
import 'package:budget/viewmodels/viewdepense.dart';
import 'package:budget/views/widgets/transactions.dart';
import 'package:flutter/material.dart';

class Listdepenses extends StatefulWidget {
  final List<Depense> depensers;
  final String emptyMessage;
  
  const Listdepenses({
    super.key,
    required this.depensers,
    required this.emptyMessage,
  });

  @override
  State<Listdepenses> createState() => _ListdepensesState();
}

class _ListdepensesState extends State<Listdepenses> {
  final Viewdepense storage = Viewdepense();
  late List<Depense> depenses;
  late String message;

  @override
  void initState() {
    super.initState();
    depenses = widget.depensers;
    message = widget.emptyMessage;
    
    if (depenses.isEmpty) {
      _chargerDepenses();
    }
  }

  Future<void> _chargerDepenses() async {
    final donnees = await storage.getAllDepenses();
    if (mounted) {
      setState(() {
        depenses = donnees;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        height: 600,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          gradient: LinearGradient(
            colors: [Colors.deepPurpleAccent, Colors.deepPurple],
          ),
        ),
        child: depenses.isEmpty
            ? _buildEmptyState()
            : _buildListContent(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.shopping_bag_outlined,
          color: Colors.white,
          size: 80,
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListContent() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: depenses.length,
      itemBuilder: (context, index) {
        return Transactions(depense: depenses[index]);
      },
    );
  }
}