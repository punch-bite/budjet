import 'package:budget/views/depense_form.dart';
import 'package:budget/views/widgets/listDepenses.dart';
import 'package:budget/views/widgets/search_form.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transactions"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DepenseForm()),
              );
            },
            icon: Icon(Icons.add_outlined),
          ),
        ],
      ),
      backgroundColor: Colors.deepPurpleAccent[700],
      body: SingleChildScrollView(
        child: Column(children: [SearchForm(), Listdepenses()]),
      ),
      // bottomNavigationBar: Menu(),
    );
  }
}
