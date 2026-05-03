import 'package:crypto/crypto.dart';
import 'dart:convert';

class BlockchainService {
  // Taux de change fixes (pour hackathon)
  static const double EUR_TO_FCFA = 656.0;
  static const double GBP_TO_FCFA = 800.0;
  static const double USD_TO_FCFA = 600.0;

  // Frais blockchain fixes
  static const double BLOCKCHAIN_FEE_PERCENTAGE = 0.008; // 0.8%
  static const double MIN_FEE_EUR = 1.50;

  // Génère un hash blockchain simulé
  static String generateBlockchainHash(
    String senderEmail,
    String receiverEmail,
    double amount,
    DateTime timestamp,
  ) {
    final data =
        '$senderEmail$receiverEmail$amount${timestamp.toIso8601String()}';
    return sha256.convert(utf8.encode(data)).toString().substring(0, 64);
  }

  // Calcule le montant reçu après frais
  static Map<String, dynamic> calculateTransfer(
    double amount,
    String currency,
  ) {
    final double exchangeRate = _getExchangeRate(currency);
    final double feeAmount =
        (amount * BLOCKCHAIN_FEE_PERCENTAGE).clamp(MIN_FEE_EUR, double.infinity);
    final double feePercentage = (feeAmount / amount) * 100;
    final double netAmount = amount - feeAmount;
    final double receivedAmount = netAmount * exchangeRate;

    return {
      'amountSent': amount,
      'currency': currency,
      'exchangeRate': exchangeRate,
      'fees': feeAmount,
      'feePercentage': feePercentage,
      'netAmount': netAmount,
      'receivedAmount': receivedAmount,
    };
  }

  // Compare avec les services traditionnels
  static Map<String, dynamic> compareServices(
    double amount,
    String currency,
  ) {
    final blockchainCalc = calculateTransfer(amount, currency);
    final exchangeRate = blockchainCalc['exchangeRate'] as double;

    // Frais traditionnels (Western Union ~10%, MoneyGram ~12%)
    final westernUnionFee = amount * 0.10;
    final moneygramFee = amount * 0.12;

    final blockchainFee = blockchainCalc['fees'];
    final savings = westernUnionFee - blockchainFee;

    return {
      'blockchain': {
        'fee': blockchainFee,
        'feePercentage': blockchainCalc['feePercentage'],
        'received': blockchainCalc['receivedAmount'],
      },
      'westernUnion': {
        'fee': westernUnionFee,
        'feePercentage': 10.0,
        'received': (amount - westernUnionFee) * exchangeRate,
      },
      'moneyGram': {
        'fee': moneygramFee,
        'feePercentage': 12.0,
        'received': (amount - moneygramFee) * exchangeRate,
      },
      'savings': savings,
    };
  }

  static double _getExchangeRate(String currency) {
    switch (currency.toUpperCase()) {
      case 'EUR':
        return EUR_TO_FCFA;
      case 'GBP':
        return GBP_TO_FCFA;
      case 'USD':
        return USD_TO_FCFA;
      default:
        return EUR_TO_FCFA;
    }
  }
}
