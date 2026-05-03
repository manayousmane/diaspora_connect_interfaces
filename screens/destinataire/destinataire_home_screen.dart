import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diaspora_connect/controllers/index.dart';
import 'package:diaspora_connect/services/fictive_data_service.dart';
import 'package:diaspora_connect/theme/app_theme.dart';
import 'package:diaspora_connect/widgets/index.dart';

class DestinatairerHomeScreen extends StatefulWidget {
  const DestinatairerHomeScreen({super.key});

  @override
  State<DestinatairerHomeScreen> createState() =>
      _DestinatairerHomeScreenState();
}

class _DestinatairerHomeScreenState extends State<DestinatairerHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalReceived = FictiveDataService.fictiveTransfersDestinataire
        .fold<double>(0, (sum, t) => sum + t.amountReceived);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 220,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.surface,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bonjour, Amara 👋',
                              style: AppTypography.heading3
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text('Heureux de vous revoir.',
                                style: AppTypography.bodySmall
                                    .copyWith(color: AppColors.textGrey)),
                          ],
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=32',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Notification card
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.accentGreen.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(
                          color: AppColors.accentGreen.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite,
                              color: AppColors.accentGreen),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Vous avez reçu 130 151 FCFA',
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.primaryGreen,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Text('de Kodjo M.',
                                    style: AppTypography.bodySmall
                                        .copyWith(
                                            color: AppColors.primaryGreen)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Balance card
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fonds disponibles',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textLight,
                              )),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            children: [
                              Text('130 151 FCFA',
                                  style: AppTypography.heading2.copyWith(
                                    color: AppColors.surface,
                                  )),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.success,
                                  borderRadius: BorderRadius.circular(AppRadius.sm),
                                ),
                                child: Text('≈ 198.40€',
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.surface,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          AppButton(
                            label: 'Retirer mes fonds',
                            
                            onPressed: () => Get.toNamed('/withdraw'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Accueil'),
                Tab(text: 'Retrait'),
                Tab(text: 'Historique'),
                Tab(text: 'Profil'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildAccueillePage(),
            _buildWithdrawPage(),
            _buildHistoryPage(),
            _buildProfilePage(),
          ],
        ),
      ),
    );
  }

  Widget _buildAccueillePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Méthodes de retrait', style: AppTypography.heading3),
          const SizedBox(height: AppSpacing.md),
          ..._buildWithdrawalMethods(),
          const SizedBox(height: AppSpacing.xl),
          Text('Réceptions récentes', style: AppTypography.heading3),
          const SizedBox(height: AppSpacing.md),
          ..._buildRecentReceptions(),
        ],
      ),
    );
  }

  List<Widget> _buildWithdrawalMethods() {
    return FictiveDataService.withdrawalMethods.entries.map((entry) {
      final method = entry.value;
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(method['icon'], style: const TextStyle(fontSize: 32)),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(method['name'],
                              style: AppTypography.bodyMedium
                                  .copyWith(fontWeight: FontWeight.bold)),
                          Text(method['speed'],
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.success,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Text('DISPONIBLE',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.success,
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Text(method['feeText'],
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.textGrey)),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildRecentReceptions() {
    return FictiveDataService.fictiveTransfersDestinataire
        .map((transfer) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.accentGreen,
              child: Text(
                transfer.senderName.substring(0, 1),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(transfer.senderName,
                style: AppTypography.bodyMedium),
            subtitle: Text('${transfer.amountReceived.toStringAsFixed(0)} FCFA',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.success,
                )),
            trailing: Text('Reçu',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.success)),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildWithdrawPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_downward_outlined,
                size: 80, color: AppColors.primaryGreen),
            const SizedBox(height: AppSpacing.lg),
            Text('Prêt à retirer vos fonds?',
                style: AppTypography.heading2, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Sélectionnez votre méthode de retrait préférée',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Commencer un retrait',
              onPressed: () => Get.toNamed('/withdraw'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('RÉCAPITULATIF MENSUEL',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textGrey)),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Total reçu ce mois',
                      style: AppTypography.heading3),
                  const SizedBox(height: AppSpacing.md),
                  Text('261 000 FCFA',
                      style: AppTypography.heading2.copyWith(
                        color: AppColors.primaryGreen,
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('TRANSACTIONS RÉCENTES',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textGrey)),
          const SizedBox(height: AppSpacing.md),
          ..._buildRecentReceptions(),
        ],
      ),
    );
  }

  Widget _buildProfilePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.lg),
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              'https://i.pravatar.cc/150?img=32',
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Amara Diop',
              style: AppTypography.heading2,
              textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.sm),
          Text('amara@benin.com',
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.textGrey)),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Text('✓ VÉRIFIÉ',
                style: AppTypography.bodySmall
                    .copyWith(color: AppColors.success)),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: AppCard(
                  child: Column(
                    children: [
                      const Icon(Icons.arrow_downward,
                          color: AppColors.success),
                      const SizedBox(height: AppSpacing.sm),
                      Text('8',
                          style: AppTypography.heading3
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text('RECEPTIONS',
                          style: AppTypography.bodySmall),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppCard(
                  child: Column(
                    children: [
                      const Icon(Icons.trending_up,
                          color: AppColors.warning),
                      const SizedBox(height: AppSpacing.sm),
                      Text('520 000 FCFA',
                          style: AppTypography.bodyMedium
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text('VOLUME TOTAL',
                          style: AppTypography.bodySmall),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: 'Déconnexion',
            onPressed: () {
              _authController.logout();
              Get.offAllNamed('/login');
            },
            backgroundColor: AppColors.error,
          ),
        ],
      ),
    );
  }
}
