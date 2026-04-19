import 'package:geniuses_school/data/models/payment_card_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:geniuses_school/presentation/state/payments_cards_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentMethodForm extends ConsumerStatefulWidget {
  final PaymentCard? card;
  final Function(PaymentCard) onSave;

  const PaymentMethodForm({super.key, this.card, required this.onSave});

  @override
  ConsumerState<PaymentMethodForm> createState() => _PaymentMethodFormState();
}

class _PaymentMethodFormState extends ConsumerState<PaymentMethodForm> {
  final _formKey = GlobalKey<FormState>();
  final _numberCtrl = TextEditingController();
  final _holderCtrl = TextEditingController();
  final _expiryMonthCtrl = TextEditingController();
  final _expiryYearCtrl = TextEditingController();
  final _cvvCtrl = TextEditingController();

  String _selectedCardType = "visa";
  int? _selectedBankId;

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authProvider);
    final card = widget.card;
    final isTeacher = authState.user!.role_id == 3;

    var initialNumber = (isTeacher ? card?.iban : card?.cardNumber) ?? "";
    if (!isTeacher && initialNumber.isNotEmpty) {
      initialNumber = CardNumberInputFormatter.format(initialNumber);
    }
    _numberCtrl.text = initialNumber;
    _holderCtrl.text =
        (isTeacher ? card?.accountHolderName : card?.cardholderName) ?? "";
    _expiryMonthCtrl.text = card?.expiryMonth?.toString() ?? "";
    _expiryYearCtrl.text = card?.expiryYear?.toString() ?? "";
    _cvvCtrl.text = card?.cvv?.toString() ?? "";
    _selectedCardType = card?.cardType ?? "visa";
    _selectedBankId = card?.bankId;
  }

  @override
  void dispose() {
    _numberCtrl.dispose();
    _holderCtrl.dispose();
    _expiryMonthCtrl.dispose();
    _expiryYearCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.read(authProvider);
    final isTeacher = authState.user!.role_id == 3;
    final isEdit = widget.card != null;
    final banksState = ref.watch(banksProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    if (isTeacher &&
        _selectedBankId == null &&
        banksState.value != null &&
        banksState.value!.isNotEmpty) {
      _selectedBankId = banksState.value!.first.id;
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isTeacher ? Icons.account_balance : Icons.credit_card,
                    color: theme.primaryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isEdit
                            ? (isTeacher ? l10n.editBankAccount : l10n.editCard)
                            : (isTeacher ? l10n.addBankAccount : l10n.addCard),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      // const SizedBox(height: 4),
                      // Text(
                      //   isTeacher
                      //       ? l10n.forReceivingEarnings
                      //       : l10n.forBookingLessons,
                      //   style: TextStyle(
                      //     fontSize: 13,
                      //     color: Colors.grey.shade600,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (isTeacher)
                      _buildTeacherForm(banksState, theme, l10n)
                    else
                      _buildStudentForm(theme, l10n),
                    const SizedBox(height: 32),
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => _handleSave(authState, banksState),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                        ),
                        child: Text(
                          isEdit
                              ? l10n.save
                              : (isTeacher
                                    ? l10n.addBankAccount
                                    : l10n.addCard),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherForm(
    AsyncValue banksState,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel(l10n.bank),
        banksState.when(
          loading: () => const CircularProgressIndicator(),
          error: (e, s) => Text(
            "${l10n.errorPrefix}$e",
            style: const TextStyle(color: Colors.red),
          ),
          data: (banks) {
            final banksList = banks as List;
            return DropdownButtonFormField<int>(
              initialValue: _selectedBankId,
              decoration: _inputDecoration(
                l10n.selectBank,
                Icons.account_balance,
                theme,
              ),
              items: banksList
                  .map<DropdownMenuItem<int>>(
                    (b) => DropdownMenuItem<int>(
                      value: b.id as int,
                      child: Text(b.name as String),
                    ),
                  )
                  .toList(),
              onChanged: (v) => setState(() => _selectedBankId = v),
              validator: (v) => v == null ? l10n.selectBank : null,
            );
          },
        ),
        const SizedBox(height: 20),
        _buildLabel(l10n.iban),
        TextFormField(
          controller: _numberCtrl,
          textDirection: TextDirection.ltr,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
            LengthLimitingTextInputFormatter(34),
          ],
          decoration: _inputDecoration(
            "SA0000000000000000000000",
            Icons.numbers,
            theme,
          ),
          validator: (v) => (v == null || v.isEmpty)
              ? l10n.required
              : (v.length < 15 ? l10n.invalid : null),
        ),
        const SizedBox(height: 20),
        _buildLabel(l10n.accountHolderName),
        TextFormField(
          controller: _holderCtrl,
          decoration: _inputDecoration(
            l10n.nameAsInBank,
            Icons.person_outline,
            theme,
          ),
          validator: (v) => (v == null || v.isEmpty)
              ? l10n.required
              : (v.length < 3 ? l10n.tooShort : null),
        ),
        const SizedBox(height: 16),
        _buildInfoBanner(
          l10n.earningsTransferNotice,
          Colors.blue,
          Icons.info_outline,
        ),
      ],
    );
  }

  Widget _buildStudentForm(ThemeData theme, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildLabel(l10n.cardType),
        DropdownButtonFormField<String>(
          initialValue: _selectedCardType,
          decoration: _inputDecoration(
            l10n.selectType,
            Icons.credit_card,
            theme,
          ),
          items: [
            DropdownMenuItem(
              value: "visa",
              child: Text(AppLocalizations.of(context)!.visa),
            ),
            DropdownMenuItem(
              value: "mastercard",
              child: Text(AppLocalizations.of(context)!.mastercard),
            ),
            DropdownMenuItem(
              value: "mada",
              child: Text(AppLocalizations.of(context)!.mada),
            ),
          ],
          onChanged: (v) => setState(() => _selectedCardType = v ?? "visa"),
        ),
        const SizedBox(height: 20),
        _buildLabel(l10n.cardNumber),
        TextFormField(
          controller: _numberCtrl,
          keyboardType: TextInputType.number,
          textDirection: TextDirection.ltr,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9 ]')),
            LengthLimitingTextInputFormatter(19),
            CardNumberInputFormatter(),
          ],
          decoration: _inputDecoration(
            "1234 5678 9012 3456",
            Icons.payment,
            theme,
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return l10n.required;
            final clean = v.replaceAll(' ', '');
            return clean.length < 13 ? l10n.invalid : null;
          },
        ),
        const SizedBox(height: 20),
        _buildLabel(l10n.cardHolderName),
        TextFormField(
          controller: _holderCtrl,
          decoration: _inputDecoration(
            l10n.nameOnCard,
            Icons.person_outline,
            theme,
          ),
          validator: (v) => (v == null || v.isEmpty)
              ? l10n.required
              : (v.length < 3 ? l10n.tooShort : null),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _buildLabel(l10n.month),
                  _buildExpiryField(_expiryMonthCtrl, "MM", theme, 12, l10n),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  _buildLabel(l10n.year),
                  _buildExpiryField(_expiryYearCtrl, "YY", theme, 99, l10n),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [_buildLabel(l10n.cvv), _buildCVVField(theme, l10n)],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildInfoBanner(
          l10n.detailsProtected,
          Colors.green,
          Icons.lock_outline,
        ),
      ],
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade700,
      ),
      textAlign: TextAlign.right,
    ),
  );

  InputDecoration _inputDecoration(
    String hint,
    IconData icon,
    ThemeData theme,
  ) => InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(color: Colors.grey.shade400),
    prefixIcon: Icon(icon, color: theme.primaryColor),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: theme.primaryColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
    filled: true,
    fillColor: Colors.grey.shade50,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );

  Widget _buildExpiryField(
    TextEditingController ctrl,
    String hint,
    ThemeData theme,
    int max,
    AppLocalizations l10n,
  ) => TextFormField(
    controller: ctrl,
    keyboardType: TextInputType.number,
    textDirection: TextDirection.ltr,
    inputFormatters: [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(2),
    ],
    decoration: _inputDecoration(
      hint,
      Icons.calendar_today,
      theme,
    ).copyWith(prefixIcon: null),
    validator: (v) {
      if (v == null || v.isEmpty) return l10n.required;
      final n = int.tryParse(v);
      if (n == null || n < 1 || n > max) return l10n.invalid;
      return null;
    },
  );

  Widget _buildCVVField(ThemeData theme, AppLocalizations l10n) =>
      TextFormField(
        controller: _cvvCtrl,
        keyboardType: TextInputType.number,
        textDirection: TextDirection.ltr,
        obscureText: true,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ],
        decoration: _inputDecoration(
          "123",
          Icons.security,
          theme,
        ).copyWith(prefixIcon: null),
        validator: (v) => (v == null || v.isEmpty)
            ? l10n.required
            : (v.length < 3 ? l10n.invalid : null),
      );

  Widget _buildInfoBanner(String text, Color color, IconData icon) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color.withValues(alpha: 0.7), size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 13, color: color.withValues(alpha: 0.9)),
          ),
        ),
      ],
    ),
  );

  void _handleSave(AuthState authState, AsyncValue banksState) {
    if (!_formKey.currentState!.validate()) return;
    final isTeacher = authState.user!.role_id == 3;
    final card = isTeacher
        ? PaymentCard(
            type: CardType.bankAccount,
            id: widget.card?.id ?? DateTime.now().millisecondsSinceEpoch,
            bankId: _selectedBankId,
            bankName: banksState.value?.firstWhere(
              (b) => b.id == _selectedBankId,
            ),
            iban: _numberCtrl.text.trim(),
            accountHolderName: _holderCtrl.text.trim(),
            isDefault: widget.card?.isDefault ?? false,
          )
        : PaymentCard(
            type: CardType.card,
            id: widget.card?.id ?? DateTime.now().millisecondsSinceEpoch,
            cardNumber: _numberCtrl.text.replaceAll(' ', ''),
            cardholderName: _holderCtrl.text.trim(),
            expiryMonth: int.tryParse(_expiryMonthCtrl.text),
            expiryYear: int.tryParse(_expiryYearCtrl.text),
            cvv: _cvvCtrl.text.trim(),
            cardType: _selectedCardType,
            isDefault: widget.card?.isDefault ?? false,
          );
    widget.onSave(card);
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    return newValue.copyWith(
      text: format(text),
      selection: TextSelection.collapsed(offset: format(text).length),
    );
  }

  static String format(String value) {
    String inputData = value;
    StringBuffer buffer = StringBuffer();
    for (var i = 0; i < inputData.length; i++) {
      if (inputData[i].contains(RegExp(r'[0-9]'))) {
        buffer.write(inputData[i]);
      }
    }

    StringBuffer newBuffer = StringBuffer();
    for (var i = 0; i < buffer.length; i++) {
      newBuffer.write(buffer.toString()[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != buffer.length) {
        newBuffer.write(' ');
      }
    }
    return newBuffer.toString();
  }
}
