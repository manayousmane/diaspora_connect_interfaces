import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diaspora_connect/controllers/index.dart';
import 'package:diaspora_connect/theme/app_theme.dart';
import 'package:diaspora_connect/widgets/index.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _loginWithEmail(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer l\'email et le mot de passe',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.surface,
      );
      return;
    }

    final success = await _authController.login(email, password);
    if (success) {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar(
        'Erreur',
        'Email ou mot de passe incorrect',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: AppColors.surface,
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.md),
              // Header
              Text(
                'DiasporaConnect',
                style: AppTypography.heading1.copyWith(
                  color: AppColors.primaryDark,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              
              // Title
              Row(
                children: [
                  Text(
                    'Bonretour ',
                    style: AppTypography.heading1.copyWith(
                      color: AppColors.primaryDark,
                      fontSize: 48,
                    ),
                  ),
                  const Text('👋', style: TextStyle(fontSize: 48)),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Connectez-vous pour continuer vos transferts sécurisés vers le pays.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textGrey,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              
              // Email Input
              AppInputField(
                label: 'Email',
                hintText: 'votre@email.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Password Input
              AppInputField(
                label: 'Mot de passe',
                hintText: '••••••••',
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Mot de passe oublié?',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              
              // Login Button
              Obx(
                () => AppButton(
                  label: 'Se connecter',
                  isLoading: _authController.isLoading.value,
                  onPressed: () {
                    _loginWithEmail(
                      _emailController.text,
                      _passwordController.text,
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              
              // Demo Accounts Section
              Center(
                child: Column(
                  children: [
                    Text(
                      '--- Comptes de démo ---',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Martin Account
                    GestureDetector(
                      onTap: () {
                        _emailController.text = 'martin@diaspora.com';
                        _passwordController.text = 'martin123';
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderLight),
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                        child: Column(
                          children: [
                            const Text('👨 Martin', style: TextStyle(fontSize: 18)),
                            const SizedBox(height: AppSpacing.sm),
                            const Text('martin@diaspora.com', style: TextStyle(fontSize: 12)),
                            const SizedBox(height: AppSpacing.sm),
                            AppButton(
                              label: 'Connecter Martin',
                              onPressed: () {
                                _loginWithEmail('martin@diaspora.com', 'martin123');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    // Koffi Account
                    GestureDetector(
                      onTap: () {
                        _emailController.text = 'koffi@benin.com';
                        _passwordController.text = 'koffi123';
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderLight),
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                        ),
                        child: Column(
                          children: [
                            const Text('👨 Koffi', style: TextStyle(fontSize: 18)),
                            const SizedBox(height: AppSpacing.sm),
                            const Text('koffi@benin.com', style: TextStyle(fontSize: 12)),
                            const SizedBox(height: AppSpacing.sm),
                            AppButton(
                              label: 'Connecter Koffi',
                              onPressed: () {
                                _loginWithEmail('koffi@benin.com', 'koffi123');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
