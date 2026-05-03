class Transfer {
  final String id;
  final String senderEmail;
  final String senderName;
  final String receiverEmail;
  final String receiverName;
  final double amountSent; // EUR ou USD
  final String currencySent; // EUR, GBP, USD
  final double amountReceived; // FCFA
  final double fees; // Frais blockchain
  final double feePercentage;
  final double exchangeRate; // 1 EUR = X FCFA
  final String status; // PENDING, COMPLETED, FAILED
  final String blockchainHash;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String? receiverWithdrawalMethod; // MTN, MOOV, AGENT_CASH
  final bool isWithdrawn;

  Transfer({
    required this.id,
    required this.senderEmail,
    required this.senderName,
    required this.receiverEmail,
    required this.receiverName,
    required this.amountSent,
    required this.currencySent,
    required this.amountReceived,
    required this.fees,
    required this.feePercentage,
    required this.exchangeRate,
    required this.status,
    required this.blockchainHash,
    required this.createdAt,
    this.completedAt,
    this.receiverWithdrawalMethod,
    this.isWithdrawn = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'senderEmail': senderEmail,
    'senderName': senderName,
    'receiverEmail': receiverEmail,
    'receiverName': receiverName,
    'amountSent': amountSent,
    'currencySent': currencySent,
    'amountReceived': amountReceived,
    'fees': fees,
    'feePercentage': feePercentage,
    'exchangeRate': exchangeRate,
    'status': status,
    'blockchainHash': blockchainHash,
    'createdAt': createdAt.toIso8601String(),
    'completedAt': completedAt?.toIso8601String(),
    'receiverWithdrawalMethod': receiverWithdrawalMethod,
    'isWithdrawn': isWithdrawn,
  };

  factory Transfer.fromMap(Map<String, dynamic> map) => Transfer(
    id: map['id'],
    senderEmail: map['senderEmail'],
    senderName: map['senderName'],
    receiverEmail: map['receiverEmail'],
    receiverName: map['receiverName'],
    amountSent: map['amountSent'],
    currencySent: map['currencySent'],
    amountReceived: map['amountReceived'],
    fees: map['fees'],
    feePercentage: map['feePercentage'],
    exchangeRate: map['exchangeRate'],
    status: map['status'],
    blockchainHash: map['blockchainHash'],
    createdAt: DateTime.parse(map['createdAt']),
    completedAt: map['completedAt'] != null ? DateTime.parse(map['completedAt']) : null,
    receiverWithdrawalMethod: map['receiverWithdrawalMethod'],
    isWithdrawn: map['isWithdrawn'] ?? false,
  );
}
