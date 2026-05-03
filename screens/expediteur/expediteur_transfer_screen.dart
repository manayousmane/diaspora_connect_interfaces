import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diaspora_connect/models/contact_model.dart';
import 'package:diaspora_connect/services/fictive_data_service.dart';
import 'package:diaspora_connect/theme/app_theme.dart';
import 'package:diaspora_connect/widgets/index.dart';

class ExpediteurTransferScreen extends StatefulWidget {
  const ExpediteurTransferScreen({super.key});

  @override
  State<ExpediteurTransferScreen> createState() =>
      _ExpediteurTransferScreenState();
}

class _ExpediteurTransferScreenState extends State<ExpediteurTransferScreen> {
  int _currentStep = 0;
  final _amountController = TextEditingController(text: '200');
  Contact? _selectedContact;
  String _selectedCurrency = 'EUR';
  
  final Map<String, double> _exchangeRates = {
    'EUR': 1.0,
    'GBP': 1.17,
    'USD': 0.92,
  };

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Envoyer de l\'argent'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textDark,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _handleContinue,
        onStepCancel: _currentStep > 0 ? _handleCancel : null,
        steps: [
          Step(
            title: const Text('Montant'),
            content: _buildAmountStep(),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.editing,
          ),
          Step(
            title: const Text('Destinataire'),
            content: _buildRecipientStep(),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.editing,
          ),
          Step(
            title: const Text('Confirmation'),
            content: _buildConfirmationStep(),
            isActive: _currentStep >= 2,
            state: StepState.editing,
          ),
        ],
      ),
    );
  }

  Widget _buildAmountStep() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final fcfaAmount = (amount * _exchangeRates[_selectedCurrency]! * 656).toStringAsFixed(0);
    final fees = (amount * 0.008).toStringAsFixed(2);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Text('Vous envoyez', style: AppTypography.bodySmall),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          style: AppTypography.heading2,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '0',
                            hintStyle: AppTypography.heading2
                                .copyWith(color: AppColors.textLight),
                          ),
                          onChanged: (value) => setState(() {}),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryDark,
                            borderRadius: BorderRadius.circular(AppRadius.sm),
                          ),
                          child: DropdownButton<String>(
                            value: _selectedCurrency,
                            onChanged: (value) =>
                                setState(() => _selectedCurrency = value!),
                            items: ['EUR', 'GBP', 'USD']
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e,
                                          style: AppTypography.bodyMedium
                                              .copyWith(
                                            color: AppColors.surface,
                                          )),
                                    ))
                                .toList(),
                            underline: const SizedBox(),
                            style: AppTypography.bodyMedium
                                .copyWith(color: AppColors.surface),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Divider(),
                  const SizedBox(height: AppSpacing.md),
                  Text('Ils reçoivent', style: AppTypography.bodySmall),
                  const SizedBox(height: AppSpacing.md),
                  Text(fcfaAmount,
                      style: AppTypography.heading2
                          .copyWith(color: AppColors.success)),
                  Text('FCFA',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.success)),
                  const SizedBox(height: AppSpacing.md),
                  const Divider(),
                  const SizedBox(height: AppSpacing.md),
                  Text('1 EUR = 656 CFA (Taux du marché)',
                      style: AppTypography.bodySmall),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Frais de transfert (0.8%)',
                          style: AppTypography.bodySmall),
                      Text('$fees€',
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.warning)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sélectionnez un destinataire',
              style: AppTypography.heading3),
          const SizedBox(height: AppSpacing.lg),
          Text('CONTACTS FRÉQUENTS',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textGrey)),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: FictiveDataService.fictiveContacts
                  .take(4)
                  .map((contact) => Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.md),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedContact = contact),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    NetworkImage(contact.profileImageUrl ?? 'https://i.pravatar.cc/150?img=0'),
                                child: _selectedContact?.email == contact.email
                                    ? Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.success,
                                            width: 3,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(contact.firstName,
                                  style: AppTypography.bodySmall),
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('TOUS LES CONTACTS',
              style: AppTypography.bodySmall
                  .copyWith(color: AppColors.textGrey)),
          const SizedBox(height: AppSpacing.md),
          ...FictiveDataService.fictiveContacts.map((contact) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(contact.profileImageUrl ?? 'https://i.pravatar.cc/150?img=0'),
                    ),
                    title: Text(contact.fullName),
                    subtitle: Text(contact.country),
                    trailing: _selectedContact?.email == contact.email
                        ? const Icon(Icons.check_circle,
                            color: AppColors.success)
                        : null,
                    onTap: () => setState(() => _selectedContact = contact),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildConfirmationStep() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final fcfaAmount = (amount * _exchangeRates[_selectedCurrency]! * 656);
    final fees = (amount * 0.008);
    final netAmount = amount - fees;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Récapitulatif du transfert',
              style: AppTypography.heading3),
          const SizedBox(height: AppSpacing.lg),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Montant envoyé',
                          style: AppTypography.bodyMedium),
                      Text('$amount$_selectedCurrency',
                          style: AppTypography.bodyMedium
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (_selectedContact != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Destinataire',
                            style: AppTypography.bodyMedium),
                        Text(_selectedContact!.fullName,
                            style: AppTypography.bodyMedium
                                .copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Frais',
                          style: AppTypography.bodyMedium),
                      Text('${fees.toStringAsFixed(2)}€',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.warning,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Divider(),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total à payer',
                          style: AppTypography.heading3),
                      Text('${amount.toStringAsFixed(2)}€',
                          style: AppTypography.heading3.copyWith(
                            color: AppColors.primaryGreen,
                          )),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text('Montant reçu',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textGrey)),
                  const SizedBox(height: AppSpacing.sm),
                  Text('${fcfaAmount.toStringAsFixed(0)} FCFA',
                      style: AppTypography.heading2
                          .copyWith(color: AppColors.success)),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Text(
                      '✓ Votre transaction est protégée par notre protocole de sécurité bancaire et vérifiée sur la blockchain DiasporaConnect.',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.success),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleContinue() {
    if (_validateStep(_currentStep)) {
      if (_currentStep < 2) {
        setState(() => _currentStep++);
      } else {
        Get.toNamed('/transfer-success');
      }
    }
  }

  void _handleCancel() {
    setState(() => _currentStep--);
  }

  bool _validateStep(int step) {
    if (step == 0) {
      if (_amountController.text.isEmpty ||
          double.tryParse(_amountController.text) == null ||
          double.tryParse(_amountController.text)! <= 0) {
        Get.snackbar('Erreur', 'Veuillez entrer un montant valide');
        return false;
      }
    } else if (step == 1) {
      if (_selectedContact == null) {
        Get.snackbar('Erreur', 'Veuillez sélectionner un destinataire');
        return false;
      }
    }
    return true;
  }
}
