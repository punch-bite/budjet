import 'package:intl/intl.dart';

String formatMoney(
  String amount, {
  String local = 'fr_FR',
  String devise = 'EUR', // Code devise ISO
  int decimalDigits = 2,
}) {
  try {
    final cleanedAmount = _cleanAmount(amount);
    final numericAmount = double.parse(cleanedAmount);

    // Mapping des symboles de devise
    final deviseSymbols = {
      'EUR': '€',
      'USD': '\$',
      'GBP': '£',
      'JPY': '¥',
      'CHF': 'CHF',
      'CAD': 'CA\$',
    };

    final symbol = deviseSymbols[devise] ?? devise;

    final formatDevise = NumberFormat.currency(
      locale: local,
      symbol: symbol,
      decimalDigits: _getDecimalDigitsForCurrency(devise, decimalDigits),
    );

    return formatDevise.format(numericAmount);
  } catch (e) {
    print('Erreur de formatage: $e');
    return amount;
  }
}

int _getDecimalDigitsForCurrency(String currency, int defaultDigits) {
  // Certaines devises n'ont pas de décimales
  final noDecimalCurrencies = ['JPY', 'KRW', 'ISK'];
  return noDecimalCurrencies.contains(currency) ? 0 : defaultDigits;
}

String _cleanAmount(String amount) {
  return amount
      .replaceAll(
        RegExp(r'[^\d.,]'),
        '',
      ) // Garder seulement chiffres, points et virgules
      .replaceAll(RegExp(r','), '.'); // Uniformiser le séparateur décimal
}
