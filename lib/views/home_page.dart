import 'package:budget/views/widgets/dashboard.dart';
import 'package:budget/views/widgets/header.dart';
import 'package:budget/views/widgets/listDepenses.dart';
import 'package:budget/views/widgets/menu.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> entries = ['A', 'B', 'C'];
  final List<int> colorCodes = [600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 90, 0, 192),
      body: SingleChildScrollView(
        child: Column(children: [Header(), Dashboard(), Listdepenses()]),
      ),
      bottomNavigationBar: Menu(),
    );
  }
}
