import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diaspora_connect/services/fictive_data_service.dart';
import 'package:diaspora_connect/theme/app_theme.dart';
import 'package:diaspora_connect/widgets/index.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  int _currentStep = 0;
  String _selectedMethod = 'mtn';
  String _selectedMethodName = 'MTN Mobile Money';
  String _pinCode = '';
  bool _showPin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Retirer mes fonds'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textDark,
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _handleContinue,
        onStepCancel: _currentStep > 0 ? _handleCancel : null,
        steps: [
          Step(
            title: const Text('Montant à retirer'),
            content: _buildAmountStep(),
            isActive: _currentStep >= 0,
            state: _currentStep > 0 ? StepState.complete : StepState.editing,
          ),
          Step(
            title: const Text('Choisir la méthode'),
            content: _buildMethodStep(),
            isActive: _currentStep >= 1,
            state: _currentStep > 1 ? StepState.complete : StepState.editing,
          ),
          Step(
            title: const Text('Confirmation PIN'),
            content: _buildConfirmationStep(),
            isActive: _currentStep >= 2,
            state: StepState.editing,
          ),
        ],
      ),
    );
  }

  Widget _buildAmountStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Solde disponible',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.textGrey)),
                  const SizedBox(height: AppSpacing.sm),
                  Text('130 151 FCFA',
                      style: AppTypography.heading2
                          .copyWith(color: AppColors.primaryGreen)),
                  Text('≈ 198.40€',
                      style: AppTypography.bodySmall
                          .copyWith(color: AppColors.success)),
                  const SizedBox(height: AppSpacing.lg),
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle,
                            color: AppColors.success, size: 20),
                        const SizedBox(width: AppSpacing.sm),
                        Text('COMPTE VÉRIFIÉ',
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.success)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Montant à retirer',
              style: AppTypography.heading3),
          const SizedBox(height: AppSpacing.md),
          TextField(
            decoration: InputDecoration(
              labelText: 'Montant',
              hintText: 'Ex: 50 000',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
            keyboardType: TextInputType.number,
            readOnly: true,
            controller: TextEditingController(text: '130 151'),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Vous pouvez retirer jusqu\'à 130 151 FCFA',
            style: AppTypography.bodySmall
                .copyWith(color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Choisissez votre méthode de retrait',
              style: AppTypography.heading3),
          const SizedBox(height: AppSpacing.lg),
          ..._buildMethodOptions(),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.info.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.info,
                        color: AppColors.info, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Tous les retraits sont sécurisés et vérifiés sur la blockchain',
                        style: AppTypography.bodySmall
                            .copyWith(color: AppColors.info),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildMethodOptions() {
    return FictiveDataService.withdrawalMethods.entries.map((entry) {
      final key = entry.key;
      final method = entry.value;
      final isSelected = _selectedMethod == key;

      return Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: GestureDetector(
          onTap: () => setState(() {
            _selectedMethod = key;
            _selectedMethodName = method['name'];
          }),
          child: Card(
            color:
                isSelected ? AppColors.primaryGreen.withOpacity(0.1) : null,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Text(method['icon'], style: const TextStyle(fontSize: 40)),
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
                              fontWeight: FontWeight.w600,
                            )),
                        Text(method['feeText'],
                            style: AppTypography.bodySmall
                                .copyWith(color: AppColors.textGrey)),
                      ],
                    ),
                  ),
                  Radio<String>(
                    value: key,
                    groupValue: _selectedMethod,
                    activeColor: AppColors.primaryGreen,
                    onChanged: (value) => setState(() {
                      _selectedMethod = value!;
                      _selectedMethodName = method['name'];
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildConfirmationStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Confirmez votre retrait',
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
                      Text('Montant du retrait',
                          style: AppTypography.bodyMedium),
                      Text('130 151 FCFA',
                          style: AppTypography.bodyMedium
                              .copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Vers $_selectedMethodName',
                          style: AppTypography.bodyMedium),
                      const Icon(Icons.check_circle,
                          color: AppColors.success),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  const Divider(),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total',
                          style: AppTypography.heading3),
                      Text('130 151 FCFA',
                          style: AppTypography.heading3.copyWith(
                            color: AppColors.success,
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Saisissez votre code PIN',
              style: AppTypography.heading3),
          const SizedBox(height: AppSpacing.md),
          // PIN Display
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm),
                    child: Container(
                      width: 50,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        border: Border.all(
                          color: index < _pinCode.length
                              ? AppColors.success
                              : AppColors.borderLight,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          index < _pinCode.length ? '●' : '',
                          style: const TextStyle(
                            fontSize: 32,
                            color: AppColors.success,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // PIN Keypad
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: AppSpacing.md,
            crossAxisSpacing: AppSpacing.md,
            children: [
              ...List.generate(9, (i) => i + 1)
                  .map((num) => _buildPinButton('$num', () => _addPin('$num')))
                  .toList(),
              _buildPinButton('*', () {}),
              _buildPinButton('0', () => _addPin('0')),
              _buildPinButton('⌫', _deletePin),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (_pinCode.length == 4)
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.shield,
                          color: AppColors.success),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Transaction sécurisée par DiasporaConnect',
                          style: AppTypography.bodySmall
                              .copyWith(color: AppColors.success),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPinButton(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: label == '⌫' ? AppColors.error : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.heading3.copyWith(
              color: label == '⌫' ? AppColors.surface : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }

  void _addPin(String digit) {
    if (_pinCode.length < 4) {
      setState(() => _pinCode += digit);
    }
  }

  void _deletePin() {
    if (_pinCode.isNotEmpty) {
      setState(() => _pinCode = _pinCode.substring(0, _pinCode.length - 1));
    }
  }

  void _handleContinue() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      if (_pinCode.length == 4 && _pinCode == '1234') {
        Get.toNamed('/withdraw-success');
      } else {
        Get.snackbar('Erreur', 'PIN incorrect');
      }
    }
  }

  void _handleCancel() {
    setState(() => _currentStep--);
  }
}
