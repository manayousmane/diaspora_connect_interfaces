import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diaspora_connect/theme/app_theme.dart';
import 'package:diaspora_connect/widgets/index.dart';

class TransferSuccessScreen extends StatelessWidget {
  const TransferSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.xl),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle,
                      size: 100, color: AppColors.success),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text('Transfert envoyé !',
                    style: AppTypography.heading2,
                    textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.md),
                Text('Votre contact a été notifié',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textGrey,
                    ),
                    textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.xl),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MONTANT ENVOYÉ',
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textGrey)),
                        const SizedBox(height: AppSpacing.sm),
                        Text('200€',
                            style: AppTypography.heading2
                                .copyWith(color: AppColors.error)),
                        const SizedBox(height: AppSpacing.lg),
                        Text('REÇU EN CFCA',
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textGrey)),
                        const SizedBox(height: AppSpacing.sm),
                        Text('130 151 CFCA',
                            style: AppTypography.heading2
                                .copyWith(color: AppColors.success)),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text('RÉFÉRENCE',
                                    style: AppTypography.bodySmall
                                        .copyWith(
                                            color: AppColors.textGrey)),
                                const SizedBox(height: AppSpacing.sm),
                                Text('#DC-2026-00847',
                                    style: AppTypography.bodyMedium
                                        .copyWith(
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text('DATE',
                                    style: AppTypography.bodySmall
                                        .copyWith(
                                            color: AppColors.textGrey)),
                                const SizedBox(height: AppSpacing.sm),
                                Text('Aujourd\'hui',
                                    style: AppTypography.bodyMedium
                                        .copyWith(
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Text(
                    '✓ Vous avez économisé 18.40€ vs Western Union',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.success),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  label: 'Retour à l\'accueil',
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                  child: Text('Télécharger le reçu',
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.primaryGreen)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WithdrawSuccessScreen extends StatelessWidget {
  const WithdrawSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              children: [
                const SizedBox(height: AppSpacing.xl),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle,
                      size: 100, color: AppColors.success),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text('Retrait réussi! 💚',
                    style: AppTypography.heading2,
                    textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.md),
                Text('L\'argent a été envoyé sur votre MTN Mobile Money',
                    style: AppTypography.bodyMedium,
                    textAlign: TextAlign.center),
                const SizedBox(height: AppSpacing.xl),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MONTANT RETIRÉ',
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textGrey)),
                        const SizedBox(height: AppSpacing.sm),
                        Text('130 151 FCFA',
                            style: AppTypography.heading2
                                .copyWith(color: AppColors.success)),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          children: [
                            const Icon(Icons.check_circle,
                                color: AppColors.success, size: 20),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text('DESTINATAIRE',
                                      style: AppTypography.bodySmall
                                          .copyWith(
                                              color: AppColors.textGrey)),
                                  Text('Vers MTN +229 97...',
                                      style: AppTypography.bodyMedium
                                          .copyWith(
                                              fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text('RÉFÉRENCE',
                                    style: AppTypography.bodySmall
                                        .copyWith(
                                            color: AppColors.textGrey)),
                                const SizedBox(height: AppSpacing.sm),
                                Text('#DC-2026-00847',
                                    style: AppTypography.bodyMedium
                                        .copyWith(
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text('DATE',
                                    style: AppTypography.bodySmall
                                        .copyWith(
                                            color: AppColors.textGrey)),
                                const SizedBox(height: AppSpacing.sm),
                                Text('Aujourd\'hui',
                                    style: AppTypography.bodyMedium
                                        .copyWith(
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.sms,
                          color: AppColors.info, size: 20),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Vous recevrez un SMS MTN confirmant le dépôt dans les prochaines minutes.',
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.info),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  label: 'Retour à l\'accueil',
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                TextButton(
                  onPressed: () {
                    Get.offAllNamed('/home');
                  },
                  child: Text('Télécharger le reçu',
                      style: AppTypography.bodyMedium
                          .copyWith(color: AppColors.primaryGreen)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
