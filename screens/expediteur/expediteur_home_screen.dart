import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diaspora_connect/controllers/index.dart';
import 'package:diaspora_connect/models/transfer_model.dart';
import 'package:diaspora_connect/services/fictive_data_service.dart';
import 'package:diaspora_connect/theme/app_theme.dart';
import 'package:diaspora_connect/widgets/index.dart';

class ExpediteurHomeScreen extends StatefulWidget {
  const ExpediteurHomeScreen({super.key});

  @override
  State<ExpediteurHomeScreen> createState() => _ExpediteurHomeScreenState();
}

class _ExpediteurHomeScreenState extends State<ExpediteurHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _authController = Get.find<AuthController>();
  final _transferController = Get.find<TransferController>();

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
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 180,
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
                        Text(
                          'Bonjour, Koffi 👋',
                          style: AppTypography.heading3
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(
                            'https://i.pravatar.cc/150?img=12',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FONDS ENVOYÉS',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textLight,
                              )),
                          const SizedBox(height: AppSpacing.sm),
                          Row(
                            children: [
                              Text('2 150 €',
                                  style: AppTypography.heading2.copyWith(
                                    color: AppColors.surface,
                                  )),
                              const Spacer(),
                              Text('≈ 1 410 400 FCFA',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.textLight,
                                  )),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.success.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppRadius.lg),
                            ),
                            child: Text('💚 Vous avez économisé 47€ ce mois',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.success,
                                )),
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
                Tab(text: 'Envoyer'),
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
            _buildSendPage(),
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
          Text('Envoi rapide', style: AppTypography.heading3),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: FictiveDataService.fictiveContacts.length + 1,
              itemBuilder: (context, index) {
                if (index == FictiveDataService.fictiveContacts.length) {
                  return Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.md),
                    child: _buildContactCircle(
                      initials: '+',
                      name: 'Nouveau',
                      onTap: () => _tabController.animateTo(1),
                    ),
                  );
                }
                final contact = FictiveDataService.fictiveContacts[index];
                return Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.md),
                  child: _buildContactCircle(
                    imageUrl: contact.profileImageUrl,
                    name: contact.fullName,
                    onTap: () => _tabController.animateTo(1),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Derniers transferts', style: AppTypography.heading3),
              TextButton(
                onPressed: () => _tabController.animateTo(2),
                child: Text('Voir tout',
                    style: AppTypography.bodySmall
                        .copyWith(color: AppColors.primaryGreen)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ..._buildTransfersList(),
        ],
      ),
    );
  }

  Widget _buildSendPage() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.send_outlined,
                size: 80, color: AppColors.primaryGreen),
            const SizedBox(height: AppSpacing.lg),
            Text('Prêt à envoyer des fonds?',
                style: AppTypography.heading2, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Cliquez sur le bouton ci-dessous pour commencer un transfert',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Envoyer de l\'argent',
              onPressed: () => Get.toNamed('/transfer'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTransfersList() {
    return FictiveDataService.fictiveTransfersExpeditor
        .take(3)
        .map((transfer) {
      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.accentGreen,
              child: Text(
                transfer.receiverName.substring(0, 1),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(transfer.receiverName,
                style: AppTypography.bodyMedium),
            subtitle: Text(transfer.createdAt.toString(),
                style: AppTypography.bodySmall),
            trailing: Text(
              '-${transfer.amountSent}€',
              style: AppTypography.bodyMedium
                  .copyWith(color: AppColors.error),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildContactCircle({
    String? imageUrl,
    String? initials,
    required String name,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.primaryGreen,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
            child: imageUrl == null
                ? Text(initials ?? name.substring(0, 1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ))
                : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: 80,
            child: Text(name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodySmall),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tous les transferts', style: AppTypography.heading3),
          const SizedBox(height: AppSpacing.md),
          ..._buildTransfersList()
              .expand((element) => [element, const SizedBox(height: 0)])
              .toList(),
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
              'https://i.pravatar.cc/150?img=12',
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Koffi Mensah',
              style: AppTypography.heading2,
              textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.sm),
          Text('koffi@benin.com',
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
                      const Icon(Icons.send_outlined,
                          color: AppColors.primaryGreen),
                      const SizedBox(height: AppSpacing.sm),
                      Text('12',
                          style: AppTypography.heading3
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text('TRANSFERTS',
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
                          color: AppColors.success),
                      const SizedBox(height: AppSpacing.sm),
                      Text('2 400€',
                          style: AppTypography.bodyMedium
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text('TOTAL ENVOYÉ',
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
