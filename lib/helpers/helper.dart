import 'package:intl/intl.dart';

class Helper {
  String formatDateAvecRelative(DateTime date) {
    final maintenant = DateTime.now();
    final aujourdhui = DateTime(
      maintenant.year,
      maintenant.month,
      maintenant.day,
    );
    final dateDuJour = DateTime(date.year, date.month, date.day);

    if (dateDuJour == aujourdhui) {
      return "Aujourd'hui, ${DateFormat('HH:mm', 'fr_FR').format(date)}";
    } else if (dateDuJour == aujourdhui.subtract(Duration(days: 1))) {
      return "Hier, ${DateFormat('HH:mm', 'fr_FR').format(date)}";
    } else {
      return DateFormat('EEEE d MMMM', 'fr_FR').format(date);
    }
  }

  String money(
    String amount, {
    String local = 'fr_FR',
    String devise = '€',
  }) {
    try {
      // Nettoyer le montant (enlever les espaces, caractères spéciaux)
      String cleanedAmount = amount.replaceAll(RegExp(r'[^\d.,]'), '');

      // Remplacer la virgule par un point pour le parsing
      cleanedAmount = cleanedAmount.replaceAll(',', '.');

      // Parser en double
      double numericAmount = double.parse(cleanedAmount);

      // Formater la devise
      final formatDevise = NumberFormat.currency(
        locale: local,
        symbol: devise,
        decimalDigits: 2,
      );

      return formatDevise.format(numericAmount);
    } catch (e) {
      // Retourner le montant original en cas d'erreur
      print('Erreur de formatage: $e');
      return '$amount $devise';
    }
  }
}
