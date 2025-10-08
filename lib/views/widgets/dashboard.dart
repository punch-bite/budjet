import 'package:budget/helpers/helper.dart';
import 'package:budget/viewmodels/viewdepense.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Viewdepense storage = Viewdepense();
  final Helper help = Helper();
  late final Map<String, dynamic> _stats;

  @override
  void initState() {
    super.initState();
    _stats = storage.getStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        children: [
          _buildStatCard(
            title: "Dépenses",
            imagePath: "images/Card_Wallet.png",
            mainValue: _stats['depenseCeMois']?['Dépense'] ?? 0.0,
            secondaryValue: _stats['parType']?['Dépense'] ?? 0.0,
          ),
          const SizedBox(width: 25),
          _buildStatCard(
            title: "Gains", 
            imagePath: "images/Cash_in_Hand.png",
            mainValue: _stats['depenseCeMois']?['Gain'] ?? 0.0,
            secondaryValue: _stats['parType']?['Gain'] ?? 0.0,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String imagePath,
    required dynamic mainValue,
    required dynamic secondaryValue,
  }) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      height: 150,
      width: 320,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(imagePath, height: 50, width: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    help.money('$mainValue', local: 'fr_FR', devise: 'FCFA'),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  Text(
                    help.money("$secondaryValue", local: 'fr_FR', devise: 'FCFA'),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color.fromARGB(255, 111, 0, 255),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}