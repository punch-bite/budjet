import 'package:budget/helpers/helper.dart';
import 'package:budget/models/depense.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  final Depense depense;
  final Helper help = Helper();
  Transactions({super.key, required this.depense});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: super.key,
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        border: Border.all(
          width: 0.5,
          color: const Color.fromARGB(151, 80, 17, 197),
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${depense.name}',
                style: TextStyle(
                  color: Colors.deepPurpleAccent[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                // ignore: unnecessary_string_interpolations
                '${help.formatDateAvecRelative(depense.created_at)}',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "images/${depense.type == 'Dépense' ? 'Giving_Tickets.png' : 'Cash_in_Hand.png'}",
                height: 32,
                width: 32,
              ),
              Text(
                help.money('${depense.montant ?? 0.0}', local: 'fr_FR', devise: 'FCFA'),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: depense.type == 'Gain' ? const Color.fromARGB(255, 1, 85, 43) : Colors.redAccent[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
