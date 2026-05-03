import 'package:diaspora_connect/models/index.dart';
import 'package:diaspora_connect/services/storage_service.dart';

class DemoDataService {
  static Future<void> initializeDemoData() async {
    // Vérifier si des données existent déjà
    final existingUser = StorageService.getUser('demo@diaspora.com');
    if (existingUser != null) {
      return; // Les données sont déjà initialisées
    }

    // Créer des utilisateurs de démo
    final expediteur = User(
      id: 'demo-expediteur-1',
      email: 'kofi@diaspora.com',
      firstName: 'Kofi',
      lastName: 'Mensah',
      phoneNumber: '+33 6 12 34 56 78',
      profileType: 'expediteur',
      isVerified: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      walletAddress: '0x1234567890abcdef1234567890abcdef12345678',
    );

    final destinataire = User(
      id: 'demo-destinataire-1',
      email: 'amara@benin.com',
      firstName: 'Amara',
      lastName: 'Diop',
      phoneNumber: '+229 97 00 00 00',
      profileType: 'destinataire',
      isVerified: true,
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      walletAddress: '0xabcdef1234567890abcdef1234567890abcdef12',
    );

    await StorageService.saveUser(expediteur);
    await StorageService.saveUser(destinataire);

    // Créer des contacts de démo
    final contacts = [
      Contact(
        email: 'amara@benin.com',
        firstName: 'Amara',
        lastName: 'Diop',
        phoneNumber: '+229 97 00 00 00',
        country: 'Bénin',
        transferCount: 5,
        totalAmountSent: 1250.0,
      ),
      Contact(
        email: 'samuel@benin.com',
        firstName: 'Samuel',
        lastName: 'Toure',
        phoneNumber: '+229 95 12 34 56',
        country: 'Bénin',
        transferCount: 3,
        totalAmountSent: 800.0,
      ),
      Contact(
        email: 'fatou@senegal.com',
        firstName: 'Fatou',
        lastName: 'Sow',
        phoneNumber: '+221 77 12 34 56',
        country: 'Sénégal',
        transferCount: 2,
        totalAmountSent: 600.0,
      ),
      Contact(
        email: 'maman@benin.com',
        firstName: 'Maman',
        lastName: 'Mensah',
        phoneNumber: '+229 90 00 00 00',
        country: 'Bénin',
        transferCount: 8,
        totalAmountSent: 2100.0,
      ),
    ];

    for (final contact in contacts) {
      await StorageService.saveContact(contact);
    }
  }
}
