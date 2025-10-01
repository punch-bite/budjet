import 'package:budget/views/home_page.dart';
import 'package:budget/views/profile_page.dart';
import 'package:budget/views/transactions_page.dart';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
            child: Image.asset(
              "images/Dashboard Gauge.png",
              height: 32,
              width: 32,
              semanticLabel: "dashborad",
              fit: BoxFit.contain,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TransactionsPage()),
              );
            },
            child: Image.asset(
              "images/Card Wallet.png",
              height: 32,
              width: 32,
              semanticLabel: "dashborad",
              fit: BoxFit.contain,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
            child: Image.asset(
              "images/Person_1.png",
              height: 32,
              width: 32,
              semanticLabel: "dashborad",
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
