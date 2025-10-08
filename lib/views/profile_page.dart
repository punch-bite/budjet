import 'package:budget/models/depense.dart';
import 'package:budget/viewmodels/viewdepense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<DateTime, dynamic> depenses = {};
  Map<DateTime, dynamic> depensesBar = {};
  final Viewdepense depenseview = Viewdepense();
  bool _isLoading = true; // Add loading state

  @override
  void initState() {
    super.initState();
    _statistics();
    _statisticsBar();
  }

  Future<void> _statistics() async {
    final donnees = depenseview.getDepenseStatsByType(
      "Dépense",
    ); // Added 'await'
    setState(() {
      depenses = donnees;
      _isLoading = false; // Data loaded
    });
  }

  Future<void> _statisticsBar() async {
    final donnees = depenseview.getDepenseStatsByType("Gain"); // Added 'await'
    setState(() {
      depensesBar = donnees;
      _isLoading = false; // Data loaded
    });
  }

  // Method to convert your data to FlSpot list
  List<FlSpot> _getChartSpotsLine() {
    // Example conversion - ADJUST based on your actual data structure
    // If your data is a list of daily amounts for the last 7 days:

    if (depenses.isNotEmpty) {
      return [
        for (final entry in depenses.entries)
          FlSpot(entry.key.day.toDouble(), entry.value),
      ];
    }
    // Fallback: Create sample data if structure is different
    return [
      FlSpot(0, 3),
      FlSpot(1, 4),
      FlSpot(2, 2),
      FlSpot(3, 5),
      FlSpot(4, 1),
      FlSpot(5, 4),
      FlSpot(6, 3),
    ];
  }

  // Method to convert your data to FlSpot list
  List<BarChartGroupData> _getChartSpotsBar() {
    // Example conversion - ADJUST based on your actual data structure
    // If your data is a list of daily amounts for the last 7 days:
    if (depensesBar.isNotEmpty) {
      // Données d'exemple si vide
      return List.generate(
        7,
        (index) => BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: (index + 1) * 2.0, // Valeurs d'exemple
              color: Colors.deepPurple.withOpacity(0.6),
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
    }
    return [];
  }

  // Méthode pour calculer la valeur Y maximale dynamiquement
  double _calculateMaxY() {
    if (depensesBar.isEmpty) return 0.0; // Valeur par défaut

    final maxValue = depensesBar.values.fold<double>(
      0.0,
      (max, value) => value > max ? value : max,
    );

    return (maxValue * 1.2).ceilToDouble(); // 20% de marge
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[700],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[700],
        foregroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Your profile section remains the same
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Image.asset(
                      "images/Person.png",
                      height: 80,
                      width: 80,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Chart Section
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purple],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Rapport des gains sur 1 mois",
                    style: TextStyle(
                      color: const Color.fromARGB(230, 255, 255, 255),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(top: 25, left: 10, right: 10),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child:
                        _isLoading
                            ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                            : LineChart(
                              duration: Duration(milliseconds: 100),
                              LineChartData(
                                backgroundColor: Colors.transparent,
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border(
                                    top: BorderSide(
                                      width: 1.0,
                                      color: Colors.white10,
                                    ),
                                  ),
                                ),
                                gridData: FlGridData(show: true),
                                titlesData: FlTitlesData(show: true),
                                minX: 0,
                                maxX: 6, // Adjust based on your data
                                minY: 0,
                                // maxY: 10, // You can set this based on your data range
                                lineBarsData: [
                                  LineChartBarData(
                                    spots:
                                        _getChartSpotsLine(), // Use the converted data
                                    isCurved: true,
                                    barWidth: 1,
                                    color:
                                        Colors
                                            .white, // Changed for better visibility
                                    belowBarData: BarAreaData(
                                      show: true,
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                  ),
                                ],
                                lineTouchData: LineTouchData(
                                  enabled: true,
                                  touchTooltipData: LineTouchTooltipData(
                                    getTooltipColor:
                                        (touchedSpot) => Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Rapport des gains sur 1 mois",
                    style: TextStyle(
                      color: const Color.fromARGB(230, 255, 255, 255),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(top: 25, left: 10, right: 10),
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child:
                        _isLoading
                            ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                            : BarChart(
                              BarChartData(
                                backgroundColor: Colors.transparent,
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                    color: Colors.white30,
                                    width: 1,
                                  ),
                                ),
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: true,
                                  getDrawingHorizontalLine:
                                      (value) => FlLine(
                                        color: Colors.white10,
                                        strokeWidth: 1,
                                      ),
                                  getDrawingVerticalLine:
                                      (value) => FlLine(
                                        color: Colors.white10,
                                        strokeWidth: 1,
                                      ),
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        final jours = [
                                          'Lun',
                                          'Mar',
                                          'Mer',
                                          'Jeu',
                                          'Ven',
                                          'Sam',
                                          'Dim',
                                        ];
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8.0,
                                          ),
                                          child: Text(
                                            value < jours.length
                                                ? jours[value.toInt()]
                                                : '',
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 10,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: (value, meta) {
                                        return Text(
                                          '${value.toInt()}€',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 10,
                                          ),
                                        );
                                      },
                                      reservedSize: 40,
                                    ),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                maxY:
                                    _calculateMaxY(), // Méthode pour calculer dynamiquement
                                minY: 0,
                                barGroups:
                                    _getChartSpotsBar(), // Méthode pour générer les données
                                barTouchData: BarTouchData(
                                  enabled: true,
                                  touchTooltipData: BarTouchTooltipData(
                                    // tooltipBgColor: Colors.deepPurple,
                                    getTooltipItem: (
                                      group,
                                      groupIndex,
                                      rod,
                                      rodIndex,
                                    ) {
                                      return BarTooltipItem(
                                        '${rod.toY.toInt()}€',
                                        TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
