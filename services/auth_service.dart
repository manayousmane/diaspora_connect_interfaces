import 'package:diaspora_connect/models/index.dart';
import 'package:diaspora_connect/services/storage_service.dart';

class AuthService {
  static const Map<String, Map<String, String>> fixedAccounts = {
    'martin@diaspora.com': {
      'password': 'martin123',
      'firstName': 'Martin',
      'lastName': 'Dupont',
      'type': 'expediteur',
      'phone': '+33612345678',
      'image': 'https://i.pravatar.cc/150?img=1',
    },
    'koffi@benin.com': {
      'password': 'koffi123',
      'firstName': 'Koffi',
      'lastName': 'Mensah',
      'type': 'destinataire',
      'phone': '+22897654321',
      'image': 'https://i.pravatar.cc/150?img=5',
    },
  };

  static Future<User?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    print('=== LOGIN ATTEMPT === Email: $email');

    if (fixedAccounts.containsKey(email)) {
      final account = fixedAccounts[email]!;
      if (account['password'] == password) {
        print('Password matches!');
        try {
          final cleanEmail = email.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
          final walletPart = cleanEmail.padRight(40, '0').substring(0, 40);
          final user = User(
            id: email.replaceAll('@', '_').replaceAll('.', '_'),
            email: email,
            firstName: account['firstName']!,
            lastName: account['lastName']!,
            phoneNumber: account['phone']!,
            profileType: account['type']!,
            profileImageUrl: account['image']!,
            isVerified: true,
            createdAt: DateTime.now(),
            walletAddress: '0x$walletPart',
          );
          await StorageService.saveUser(user);
          await StorageService.setCurrentUser(user);
          print('User saved: ${user.email}');
          return user;
        } catch (e) {
          print('Error saving user: $e');
          return null;
        }
      }
    }
    print('Login failed');
    return null;
  }

  static Future<void> logout() async {
    await StorageService.clearCurrentUser();
  }
}
