import 'package:flutter/material.dart';
import 'package:path/path.dart' show context;
// import 'package:path/path.dart';

class Notification {
  // Enum NotificationType { success, error, warning, info }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> notifyMe(
    String statut,
    String message,
  ) {
    // Vérification de sécurité du contexte
    final currentContext = context as BuildContext;
    // if (!currentContext.mounted) {
    //   // Retourner un controller vide si le contexte n'est plus monté
    //   return ScaffoldFeatureController<SnackBar, SnackBarClosedReason>._();
    // }

    return ScaffoldMessenger.of(currentContext).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: _getSnackBarColor(statut),
        duration: Duration(seconds: statut == 'error' ? 4 : 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(currentContext).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  // Fonction helper pour gérer les couleurs
  Color? _getSnackBarColor(String statut) {
    switch (statut.toLowerCase()) {
      case 'error':
        return Colors.redAccent[700];
      case 'success':
        return Colors.greenAccent[700];
      case 'warning':
        return Colors.orangeAccent[700];
      case 'info':
        return Colors.blueAccent[700];
      default:
        return Colors.grey[700];
    }
  }
}
