import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/bank_model.dart';
import '../../../data/models/payment_card_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../state/payments_cards_provider.dart';

class TeacherAddBankAccountSheet extends ConsumerStatefulWidget {
  const TeacherAddBankAccountSheet({super.key});

  @override
  ConsumerState<TeacherAddBankAccountSheet> createState() =>
      _TeacherAddBankAccountSheetState();
}

class _TeacherAddBankAccountSheetState
    extends ConsumerState<TeacherAddBankAccountSheet> {
  final _formKey = GlobalKey<FormState>();
  BankModel? _selectedBank;
  final _holderNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _ibanController = TextEditingController();
  bool _isDefault = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _holderNameController.dispose();
    _accountNumberController.dispose();
    _ibanController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _selectedBank == null) return;

    setState(() => _isSubmitting = true);

    try {
      final newMethod = PaymentCard(
        type: CardType.bankAccount,
        bankId: _selectedBank!.id,
        accountHolderName: _holderNameController.text,
        accountNumber: _accountNumberController.text,
        iban: _ibanController.text,
        isDefault: _isDefault,
      );

      await ref.read(paymentCardProvider.notifier).addPaymentCard(newMethod);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.cardAddedSuccess),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.cardAddError(e.toString()),
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final banksAsync = ref.watch(banksProvider);
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.addNewBankAccount,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Bank Selection
              banksAsync.when(
                data: (banks) => DropdownButtonFormField<BankModel>(
                  initialValue: _selectedBank,
                  decoration: InputDecoration(
                    labelText: loc.selectBank,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: banks
                      .map(
                        (bank) => DropdownMenuItem(
                          value: bank,
                          child: Text(bank.name),
                        ),
                      )
                      .toList(),
                  onChanged: (val) => setState(() => _selectedBank = val),
                  validator: (val) => val == null ? loc.fieldRequired : null,
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text(loc.errorLoadingBanks),
              ),
              const SizedBox(height: 16),

              // Account Holder Name
              TextFormField(
                controller: _holderNameController,
                decoration: InputDecoration(
                  labelText: loc.accountHolderName,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? loc.fieldRequired : null,
              ),
              const SizedBox(height: 16),

              // Account Number
              TextFormField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: loc.accountNumber,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val == null || val.isEmpty ? loc.fieldRequired : null,
              ),
              const SizedBox(height: 16),

              // IBAN
              TextFormField(
                controller: _ibanController,
                decoration: InputDecoration(
                  labelText: loc.iban,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: 'SA...',
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return loc.fieldRequired;
                  if (!val.toUpperCase().startsWith('SA')) return loc.invalid;
                  if (val.length != 24) return loc.invalid;
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Default toggle
              SwitchListTile(
                title: Text(loc.cardDefault),
                value: _isDefault,
                onChanged: (val) => setState(() => _isDefault = val),
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(loc.confirm),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
