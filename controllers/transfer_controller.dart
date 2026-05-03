import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:diaspora_connect/models/index.dart';
import 'package:diaspora_connect/services/index.dart';
import 'package:diaspora_connect/controllers/auth_controller.dart';

class TransferController extends GetxController {
  static const uuid = Uuid();

  RxList<Transfer> transfers = <Transfer>[].obs;
  RxList<Contact> contacts = <Contact>[].obs;
  RxBool isLoading = false.obs;
  RxDouble totalSent = 0.0.obs;
  RxDouble totalSaved = 0.0.obs;
  RxInt familiesSupported = 0.obs;
  late AuthController _authController;

  @override
  void onInit() {
    super.onInit();
    _authController = Get.find<AuthController>();
    loadTransfers();
    loadContacts();
  }

  void loadTransfers() {
    final authController = Get.find<AuthController>();
    if (authController.currentUser.value != null) {
      final userTransfers =
          StorageService.getTransfersByEmail(
              authController.currentUser.value!.email);
      transfers.assignAll(userTransfers);
      _calculateStats();
    }
  }

  void loadContacts() {
    contacts.assignAll(StorageService.getAllContacts());
  }

  Future<Transfer?> createTransfer({
    required String receiverEmail,
    required String receiverName,
    required double amountSent,
    required String currency,
  }) async {
    final authController = Get.find<AuthController>();
    if (authController.currentUser.value == null) return null;

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final currentUser = authController.currentUser.value!;
      final calc = BlockchainService.calculateTransfer(amountSent, currency);

      final transfer = Transfer(
        id: uuid.v4(),
        senderEmail: currentUser.email,
        senderName: currentUser.fullName,
        receiverEmail: receiverEmail,
        receiverName: receiverName,
        amountSent: amountSent,
        currencySent: currency,
        amountReceived: calc['receivedAmount'] as double,
        fees: calc['fees'] as double,
        feePercentage: calc['feePercentage'] as double,
        exchangeRate: calc['exchangeRate'] as double,
        status: 'PENDING',
        blockchainHash: BlockchainService.generateBlockchainHash(
          currentUser.email,
          receiverEmail,
          amountSent,
          DateTime.now(),
        ),
        createdAt: DateTime.now(),
      );

      await StorageService.saveTransfer(transfer);
      transfers.add(transfer);

      // Simuler une complétion après 3 secondes
      Future.delayed(const Duration(seconds: 3), () async {
        final updatedTransfer = Transfer(
          id: transfer.id,
          senderEmail: transfer.senderEmail,
          senderName: transfer.senderName,
          receiverEmail: transfer.receiverEmail,
          receiverName: transfer.receiverName,
          amountSent: transfer.amountSent,
          currencySent: transfer.currencySent,
          amountReceived: transfer.amountReceived,
          fees: transfer.fees,
          feePercentage: transfer.feePercentage,
          exchangeRate: transfer.exchangeRate,
          status: 'COMPLETED',
          blockchainHash: transfer.blockchainHash,
          createdAt: transfer.createdAt,
          completedAt: DateTime.now(),
        );
        await StorageService.updateTransfer(updatedTransfer);
        transfers[transfers.indexWhere((t) => t.id == transfer.id)] =
            updatedTransfer;
        _calculateStats();
      });

      _calculateStats();
      isLoading.value = false;
      return transfer;
    } catch (e) {
      isLoading.value = false;
      return null;
    }
  }

  Future<bool> withdrawTransfer(
    String transferId,
    String withdrawalMethod,
    String pin,
  ) async {
    isLoading.value = true;

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      final transfer = StorageService.getTransfer(transferId);
      if (transfer != null) {
        final updatedTransfer = Transfer(
          id: transfer.id,
          senderEmail: transfer.senderEmail,
          senderName: transfer.senderName,
          receiverEmail: transfer.receiverEmail,
          receiverName: transfer.receiverName,
          amountSent: transfer.amountSent,
          currencySent: transfer.currencySent,
          amountReceived: transfer.amountReceived,
          fees: transfer.fees,
          feePercentage: transfer.feePercentage,
          exchangeRate: transfer.exchangeRate,
          status: 'COMPLETED',
          blockchainHash: transfer.blockchainHash,
          createdAt: transfer.createdAt,
          completedAt: transfer.completedAt ?? DateTime.now(),
          receiverWithdrawalMethod: withdrawalMethod,
          isWithdrawn: true,
        );

        await StorageService.updateTransfer(updatedTransfer);
        final index = transfers.indexWhere((t) => t.id == transferId);
        if (index != -1) {
          transfers[index] = updatedTransfer;
        }

        isLoading.value = false;
        return true;
      }

      isLoading.value = false;
      return false;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  void addContact(Contact contact) {
    StorageService.saveContact(contact);
    contacts.add(contact);
  }

  void _calculateStats() {
    final authController = Get.find<AuthController>();
    totalSent.value = 0;
    totalSaved.value = 0;
    final uniqueReceivers = <String>{};

    for (var transfer in transfers) {
      if (transfer.senderEmail == authController.currentUser.value?.email) {
        totalSent.value += transfer.amountSent;
        totalSaved.value += transfer.fees;
        uniqueReceivers.add(transfer.receiverEmail);
      }
    }

    familiesSupported.value = uniqueReceivers.length;
  }

  List<Transfer> getSentTransfers() {
    final authController = Get.find<AuthController>();
    return transfers
        .where((t) => t.senderEmail == authController.currentUser.value?.email)
        .toList();
  }

  List<Transfer> getReceivedTransfers() {
    final authController = Get.find<AuthController>();
    return transfers
        .where((t) => t.receiverEmail == authController.currentUser.value?.email)
        .toList();
  }

  double getTotalBalanceReceived() {
    final authController = Get.find<AuthController>();
    double balance = 0;
    for (var transfer in transfers) {
      if (transfer.receiverEmail == authController.currentUser.value?.email &&
          !transfer.isWithdrawn) {
        balance += transfer.amountReceived;
      }
    }
    return balance;
  }

  double getTotalSaved() {
    final authController = Get.find<AuthController>();
    double saved = 0;
    for (var transfer in transfers) {
      if (transfer.senderEmail == authController.currentUser.value?.email) {
        // Comparer avec Western Union
        final westernUnionFee = transfer.amountSent * 0.10;
        saved += (westernUnionFee - transfer.fees);
      }
    }
    return saved;
  }

  double getTotalReceived() {
    final authController = Get.find<AuthController>();
    double total = 0;
    for (var transfer in transfers) {
      if (transfer.receiverEmail == authController.currentUser.value?.email) {
        total += transfer.amountReceived;
      }
    }
    return total;
  }

  double getTotalWithdrawn() {
    return 0; // TODO: Implement when withdrawal feature is added
  }
}
