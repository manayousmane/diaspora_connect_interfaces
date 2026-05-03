import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diaspora_connect/controllers/index.dart';
import 'package:diaspora_connect/theme/app_theme.dart';
import 'package:diaspora_connect/widgets/index.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;
  String _selectedProfile = 'expediteur';
  final _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Créer un compte'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vous êtes ?',
                style: AppTypography.heading3,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedProfile = 'expediteur';
                        });
                      },
                      child: AppCard(
                        backgroundColor: _selectedProfile == 'expediteur'
                            ? AppColors.primaryGreen
                            : AppColors.surface,
                        border: Border.all(
                          color: _selectedProfile == 'expediteur'
                              ? AppColors.primaryGreen
                              : AppColors.borderLight,
                          width: 2,
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.send,
                              size: 40,
                              color: AppColors.primaryGreen,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Expéditeur',
                              style: AppTypography.bodyMedium.copyWith(
                                color: _selectedProfile == 'expediteur'
                                    ? AppColors.surface
                                    : AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedProfile = 'destinataire';
                        });
                      },
                      child: AppCard(
                        backgroundColor: _selectedProfile == 'destinataire'
                            ? AppColors.primaryGreen
                            : AppColors.surface,
                        border: Border.all(
                          color: _selectedProfile == 'destinataire'
                              ? AppColors.primaryGreen
                              : AppColors.borderLight,
                          width: 2,
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.home,
                              size: 40,
                              color: AppColors.primaryGreen,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Destinataire',
                              style: AppTypography.bodyMedium.copyWith(
                                color: _selectedProfile == 'destinataire'
                                    ? AppColors.surface
                                    : AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              AppInputField(
                label: 'Prénom',
                hintText: 'Kofi',
                controller: _firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Prénom requis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppInputField(
                label: 'Nom',
                hintText: 'Mensah',
                controller: _lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nom requis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppInputField(
                label: 'Email',
                hintText: 'votre@email.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email requis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppInputField(
                label: 'Téléphone',
                hintText: '+229 97 00 00 00',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Téléphone requis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              AppInputField(
                label: 'Mot de passe',
                hintText: '••••••••',
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Mot de passe requis';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              Obx(
                () => AppButton(
                  label: 'Continuer',
                  isLoading: _authController.isLoading.value,
                  onPressed: () async {
                    // Signup is disabled - using fixed demo accounts only
                    Get.snackbar(
                      'Non disponible',
                      'Veuillez utiliser les comptes de démo',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
