import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../edit_profile_widgets/teacher_preferences_form.dart';

class TeacherServicesManagementWidget extends ConsumerStatefulWidget {
  const TeacherServicesManagementWidget({super.key});

  @override
  ConsumerState<TeacherServicesManagementWidget> createState() =>
      _TeacherServicesManagementWidgetState();
}

class _TeacherServicesManagementWidgetState
    extends ConsumerState<TeacherServicesManagementWidget> {
  final _singleLessonPriceController = TextEditingController();

  bool _teachSingleLesson = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).user;
    if (user?.profile != null) {
      _teachSingleLesson = user!.profile!.teach_individual ?? false;
      _singleLessonPriceController.text =
          user.profile!.individual_hour_price != 0.0
          ? user.profile!.individual_hour_price.toString()
          : "";
    }
  }

  Future<void> _savePreferences() async {
    setState(() => _isSaving = true);
    final l10n = AppLocalizations.of(context)!;

    try {
      await ref
          .read(authProvider.notifier)
          .updateTeacherInfo(
            teachIndividual: _teachSingleLesson,
            individualHourPrice: _singleLessonPriceController.text.isNotEmpty
                ? double.parse(_singleLessonPriceController.text)
                : 0.0,
            teachGroup: false,
            groupHourPrice: 0.0,
            minGroupSize: 0,
            maxGroupSize: 0,
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.saveSuccess),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      Logger.log("Error saving teacher preferences: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.saveFailed(e.toString())),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.servicesProvided, // Or a more specific title if available
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_isSaving)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              TextButton.icon(
                onPressed: _savePreferences,
                icon: const Icon(Icons.save, size: 18),
                label: Text(l10n.saveButton),
              ),
          ],
        ),
        const SizedBox(height: 12),
        TeacherPreferencesForm(
          teachSingleLesson: _teachSingleLesson,
          singleLessonPriceController: _singleLessonPriceController,
          onTeachSingleChanged: (val) {
            setState(() {
              _teachSingleLesson = val;
              if (!val) _singleLessonPriceController.clear();
            });
          },
        ),
        const SizedBox(height: 16),
        // Bank Account Shortcut
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/payment-methods');
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.account_balance_outlined,
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.manageBankAccount,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l10n.forReceivingEarnings,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _singleLessonPriceController.dispose();
    super.dispose();
  }
}
