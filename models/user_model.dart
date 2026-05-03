class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String profileType; // 'expediteur' ou 'destinataire'
  final String? profileImageUrl;
  final bool isVerified;
  final DateTime createdAt;
  final String walletAddress;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileType,
    this.profileImageUrl,
    required this.isVerified,
    required this.createdAt,
    required this.walletAddress,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'firstName': firstName,
    'lastName': lastName,
    'phoneNumber': phoneNumber,
    'profileType': profileType,
    'profileImageUrl': profileImageUrl,
    'isVerified': isVerified,
    'createdAt': createdAt.toIso8601String(),
    'walletAddress': walletAddress,
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'],
    email: map['email'],
    firstName: map['firstName'],
    lastName: map['lastName'],
    phoneNumber: map['phoneNumber'],
    profileType: map['profileType'],
    profileImageUrl: map['profileImageUrl'],
    isVerified: map['isVerified'] ?? false,
    createdAt: DateTime.parse(map['createdAt']),
    walletAddress: map['walletAddress'],
  );

  String get fullName => '$firstName $lastName';
}
