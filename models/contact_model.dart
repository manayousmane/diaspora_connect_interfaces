class Contact {
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String? profileImageUrl;
  final String country;
  final int transferCount;
  final double totalAmountSent;

  Contact({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.profileImageUrl,
    required this.country,
    this.transferCount = 0,
    this.totalAmountSent = 0,
  });

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toMap() => {
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'profileImageUrl': profileImageUrl,
    'country': country,
    'transferCount': transferCount,
    'totalAmountSent': totalAmountSent,
  };

  factory Contact.fromMap(Map<String, dynamic> map) => Contact(
    email: map['email'],
    firstName: map['firstName'],
    lastName: map['lastName'],
    phoneNumber: map['phoneNumber'],
    profileImageUrl: map['profileImageUrl'],
    country: map['country'],
    transferCount: map['transferCount'] ?? 0,
    totalAmountSent: map['totalAmountSent'] ?? 0,
  );
}
