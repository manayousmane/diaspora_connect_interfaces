import 'package:diaspora_connect/models/contact_model.dart';
import 'package:diaspora_connect/models/transfer_model.dart';

class FictiveDataService {
  // Contacts fictifs pour carousel et contacts rapides
  static final List<Contact> fictiveContacts = [
    Contact(
      firstName: 'Maman',
      lastName: '',
      email: 'maman@family.com',
      country: 'Bénin',
      phoneNumber: '+229 97654321',
      profileImageUrl: 'https://i.pravatar.cc/150?img=1',
      transferCount: 5,
      totalAmountSent: 0,
    ),
    Contact(
      firstName: 'Papa',
      lastName: '',
      email: 'papa@family.com',
      country: 'Bénin',
      phoneNumber: '+229 98765432',
      profileImageUrl: 'https://i.pravatar.cc/150?img=2',
      transferCount: 3,
      totalAmountSent: 0,
    ),
    Contact(
      firstName: 'Sœur',
      lastName: 'Aïcha',
      email: 'aicha@family.com',
      country: 'Bénin',
      phoneNumber: '+229 99876543',
      profileImageUrl: 'https://i.pravatar.cc/150?img=3',
      transferCount: 2,
      totalAmountSent: 0,
    ),
    Contact(
      firstName: 'Kodjo',
      lastName: 'Mensah',
      email: 'kodjo@benin.com',
      country: 'Bénin',
      phoneNumber: '+229 90123456',
      profileImageUrl: 'https://i.pravatar.cc/150?img=4',
      transferCount: 1,
      totalAmountSent: 0,
    ),
    Contact(
      firstName: 'Amara',
      lastName: 'Diop',
      email: 'amara@senegal.com',
      country: 'Sénégal',
      phoneNumber: '+221 77123456',
      profileImageUrl: 'https://i.pravatar.cc/150?img=5',
      transferCount: 0,
      totalAmountSent: 0,
    ),
    Contact(
      firstName: 'Moussa',
      lastName: 'Diop',
      email: 'moussa@senegal.com',
      country: 'Sénégal',
      phoneNumber: '+221 78234567',
      profileImageUrl: 'https://i.pravatar.cc/150?img=6',
      transferCount: 0,
      totalAmountSent: 0,
    ),
    Contact(
      firstName: 'Yasmine',
      lastName: 'Zinsou',
      email: 'yasmine@benin.com',
      country: 'Bénin',
      phoneNumber: '+229 91234567',
      profileImageUrl: 'https://i.pravatar.cc/150?img=7',
      transferCount: 0,
      totalAmountSent: 0,
    ),
    Contact(
      firstName: 'Balla',
      lastName: 'Keita',
      email: 'balla@guinea.com',
      country: 'Guinée',
      phoneNumber: '+224 612345678',
      profileImageUrl: 'https://i.pravatar.cc/150?img=8',
      transferCount: 0,
      totalAmountSent: 0,
    ),
  ];

  // Virements fictifs pour expéditeur (Martin)
  static final List<Transfer> fictiveTransfersExpeditor = [
    Transfer(
      id: 'TRX001',
      senderEmail: 'martin@diaspora.com',
      senderName: 'Martin Dupont',
      receiverEmail: 'maman@family.com',
      receiverName: 'Maman',
      amountSent: 200.0,
      currencySent: 'EUR',
      amountReceived: 130151.0,
      fees: 1.60,
      feePercentage: 0.008,
      exchangeRate: 656.0,
      status: 'completed',
      blockchainHash: 'dc2b4a8c1e9f3d7b2c5e1a9d8f4c6e2b9a7d3f1c5e8b2a6d9c1f4e7b0a3d6c9',
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
    ),
    Transfer(
      id: 'TRX002',
      senderEmail: 'martin@diaspora.com',
      senderName: 'Martin Dupont',
      receiverEmail: 'papa@family.com',
      receiverName: 'Papa',
      amountSent: 150.0,
      currencySent: 'EUR',
      amountReceived: 97613.0,
      fees: 1.20,
      feePercentage: 0.008,
      exchangeRate: 656.0,
      status: 'completed',
      blockchainHash: 'a4c2d1e5f8b9c3a7d6e1f4c2b9a8d7e6f5c4b3a2d1e0f9c8b7a6d5e4f3c2b1',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transfer(
      id: 'TRX003',
      senderEmail: 'martin@diaspora.com',
      senderName: 'Martin Dupont',
      receiverEmail: 'aicha@family.com',
      receiverName: 'Sœur Aïcha',
      amountSent: 100.0,
      currencySent: 'EUR',
      amountReceived: 65075.0,
      fees: 0.80,
      feePercentage: 0.008,
      exchangeRate: 656.0,
      status: 'completed',
      blockchainHash: 'f1c5d2e8a3b9c7d4e1f6a2b8c5d9e3f7a4b1c6d2e8f3a9b5c1d7e4f0a6b2c9',
      createdAt: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transfer(
      id: 'TRX004',
      senderEmail: 'martin@diaspora.com',
      senderName: 'Martin Dupont',
      receiverEmail: 'kodjo@benin.com',
      receiverName: 'Kodjo Mensah',
      amountSent: 320.0,
      currencySent: 'EUR',
      amountReceived: 208240.0,
      fees: 2.56,
      feePercentage: 0.008,
      exchangeRate: 656.0,
      status: 'completed',
      blockchainHash: 'b8e2c4f1d9a5c3f7e2b6a1d8c5f3a9d4e1c6b2f7a3d8e4c9b1f5a2d7e3c6f0',
      createdAt: DateTime.now().subtract(Duration(days: 10)),
    ),
  ];

  // Virements fictifs pour destinataire (Koffi)
  static final List<Transfer> fictiveTransfersDestinataire = [
    Transfer(
      id: 'TRX005',
      senderEmail: 'kodjo@benin.com',
      senderName: 'Kodjo Mensah',
      receiverEmail: 'koffi@benin.com',
      receiverName: 'Koffi Kofi',
      amountSent: 250.0,
      currencySent: 'GBP',
      amountReceived: 192502.0,
      fees: 2.00,
      feePercentage: 0.008,
      exchangeRate: 767.0,
      status: 'completed',
      blockchainHash: 'c1f4d8a2b6e3c9f5d1a7b2e8c4f1a6d3e9c5b2f8a4d7e1c9b3f6a2d8e5c1f7',
      createdAt: DateTime.now().subtract(Duration(hours: 24)),
    ),
    Transfer(
      id: 'TRX006',
      senderEmail: 'amara@senegal.com',
      senderName: 'Amara Diop',
      receiverEmail: 'koffi@benin.com',
      receiverName: 'Koffi Kofi',
      amountSent: 175.0,
      currencySent: 'USD',
      amountReceived: 106042.0,
      fees: 1.40,
      feePercentage: 0.008,
      exchangeRate: 603.0,
      status: 'completed',
      blockchainHash: 'd5a3c1f7e2b9d6a4c8f1d7b2e5c9f3a6d1c7b4e8f2a5d9c3f6b1e4a8d2c5f9',
      createdAt: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transfer(
      id: 'TRX007',
      senderEmail: 'moussa@senegal.com',
      senderName: 'Moussa Diop',
      receiverEmail: 'koffi@benin.com',
      receiverName: 'Koffi Kofi',
      amountSent: 400.0,
      currencySent: 'EUR',
      amountReceived: 262606.0,
      fees: 3.20,
      feePercentage: 0.008,
      exchangeRate: 656.0,
      status: 'completed',
      blockchainHash: 'a2e7c4f1b8d3a6f9c5e2d8a1f7b4c9e6d1a5c2f8b3e7d4a9c6f1b5e2d9a3f6',
      createdAt: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

  // Méthodes de retrait fictives
  static final Map<String, dynamic> withdrawalMethods = {
    'mtn': {
      'name': 'MTN Money',
      'icon': '📱',
      'speed': 'Instant',
      'fee': 'Gratuit',
      'available': true,
      'description': 'Transfert immédiat sur votre compte MTN Money',
    },
    'moov': {
      'name': 'Moov Money',
      'icon': '📲',
      'speed': '2-5 min',
      'fee': 'Gratuit',
      'available': true,
      'description': 'Reçu rapidement sur votre compte Moov Money',
    },
    'agent': {
      'name': 'Retrait en agence',
      'icon': '🏪',
      'speed': '15-30 min',
      'fee': '100 FCFA',
      'available': true,
      'description': 'Retrait en espèces dans nos agences partenaires',
    },
  };

  // Obtenir les 4 premiers contacts pour le carousel
  static List<Contact> getFrequentContacts() {
    return fictiveContacts.take(4).toList();
  }

  // Obtenir les 3 derniers virements
  static List<Transfer> getRecentTransfers(List<Transfer> transfers) {
    final sorted = List<Transfer>.from(transfers);
    sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted.take(3).toList();
  }
}
