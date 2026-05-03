import 'package:hive_flutter/hive_flutter.dart';
import 'package:diaspora_connect/models/index.dart';

class StorageService {
  static const String _usersBox = 'users';
  static const String _transfersBox = 'transfers';
  static const String _contactsBox = 'contacts';
  static const String _currentUserKey = 'current_user';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_usersBox);
    await Hive.openBox(_transfersBox);
    await Hive.openBox(_contactsBox);
  }

  // USER OPERATIONS
  static Future<void> saveUser(User user) async {
    final box = Hive.box(_usersBox);
    await box.put(user.email, user.toMap());
  }

  static User? getUser(String email) {
    final box = Hive.box(_usersBox);
    final data = box.get(email);
    if (data != null) {
      return User.fromMap(Map<String, dynamic>.from(data));
    }
    return null;
  }

  static Future<void> setCurrentUser(User user) async {
    final box = Hive.box(_usersBox);
    await box.put(_currentUserKey, user.toMap());
  }

  static User? getCurrentUser() {
    final box = Hive.box(_usersBox);
    final data = box.get(_currentUserKey);
    if (data != null) {
      return User.fromMap(Map<String, dynamic>.from(data));
    }
    return null;
  }

  static Future<void> clearCurrentUser() async {
    final box = Hive.box(_usersBox);
    await box.delete(_currentUserKey);
  }

  // TRANSFER OPERATIONS
  static Future<void> saveTransfer(Transfer transfer) async {
    final box = Hive.box(_transfersBox);
    await box.put(transfer.id, transfer.toMap());
  }

  static List<Transfer> getTransfersByEmail(String email) {
    final box = Hive.box(_transfersBox);
    final transfers = <Transfer>[];
    for (var key in box.keys) {
      final data = box.get(key);
      if (data != null) {
        final transfer = Transfer.fromMap(Map<String, dynamic>.from(data));
        if (transfer.senderEmail == email || transfer.receiverEmail == email) {
          transfers.add(transfer);
        }
      }
    }
    transfers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return transfers;
  }

  static Transfer? getTransfer(String id) {
    final box = Hive.box(_transfersBox);
    final data = box.get(id);
    if (data != null) {
      return Transfer.fromMap(Map<String, dynamic>.from(data));
    }
    return null;
  }

  static Future<void> updateTransfer(Transfer transfer) async {
    final box = Hive.box(_transfersBox);
    await box.put(transfer.id, transfer.toMap());
  }

  // CONTACT OPERATIONS
  static Future<void> saveContact(Contact contact) async {
    final box = Hive.box(_contactsBox);
    await box.put(contact.email, contact.toMap());
  }

  static Contact? getContact(String email) {
    final box = Hive.box(_contactsBox);
    final data = box.get(email);
    if (data != null) {
      return Contact.fromMap(Map<String, dynamic>.from(data));
    }
    return null;
  }

  static List<Contact> getAllContacts() {
    final box = Hive.box(_contactsBox);
    final contacts = <Contact>[];
    for (var key in box.keys) {
      final data = box.get(key);
      if (data != null) {
        contacts.add(Contact.fromMap(Map<String, dynamic>.from(data)));
      }
    }
    return contacts;
  }
}
