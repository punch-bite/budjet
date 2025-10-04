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

  
}
