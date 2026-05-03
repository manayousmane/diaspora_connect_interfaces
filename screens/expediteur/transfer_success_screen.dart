import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:diaspora_connect/models/index.dart';
import 'package:diaspora_connect/theme/app_theme.dart';
import 'package:diaspora_connect/widgets/index.dart';

class TransferSuccessScreen extends StatelessWidget {
  const TransferSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transfer = Get.arguments as Transfer;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSpacing.xl),

              // Success Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.accentGreen,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentGreen.withOpacity(0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.surface,
                  size: 60,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Title
              Text(
                'Transfert envoyé !',
                style: AppTypography.heading1,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Votre contact a été notifié',
                style: AppTypography.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),

              // Amount Box
              AppCard(
                backgroundColor: AppColors.primaryDark,
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MONTANT ENVOYÉ',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.surface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${transfer.amountSent}${transfer.currencySent}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.surface,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'REÇU EN FCFA',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.accentGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                '${transfer.amountReceived.toStringAsFixed(0)}',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accentGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Recipient Info
              AppCard(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                      child: Center(
                        child: Text(
                          transfer.receiverName[0],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.surface,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transfer.receiverName,
                            style: AppTypography.bodyMedium,
                          ),
                          Text(
                            transfer.receiverEmail,
                            style: AppTypography.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Savings
              AppCard(
                backgroundColor: AppColors.success.withOpacity(0.1),
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.trending_down,
                          color: AppColors.success,
                          size: 32,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Économie',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.textGrey,
                              ),
                            ),
                            Text(
                              'DiasporaConnect',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.success,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          '${(transfer.amountSent * 0.10 - transfer.fees).toStringAsFixed(2)}€',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Par rapport aux services classiques',
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Blockchain Info
              AppCard(
                backgroundColor: AppColors.info.withOpacity(0.1),
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.info,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Confirmé sur blockchain',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.info,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                transfer.blockchainHash.substring(0, 20) +
                                    '...',
                                style: AppTypography.caption,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // Download receipt button
              OutlinedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download),
                    SizedBox(width: AppSpacing.sm),
                    Text('Télécharger le reçu'),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Back button
              AppButton(
                label: 'Retour à l\'accueil',
                onPressed: () => Get.offAllNamed('/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
