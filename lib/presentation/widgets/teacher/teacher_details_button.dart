import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:geniuses_school/presentation/widgets/profile/complete_profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/app_localizations.dart';
import '../../screens/teacher/teacher_detail_screen.dart';

class TeacherDetailsButton extends ConsumerWidget {
  final BuildContext context;
  final Map<String, dynamic> teacher;
  final ThemeData? theme;

  const TeacherDetailsButton({
    super.key,
    required this.context,
    required this.teacher,
    this.theme,
  });

  void _showTeacherDetails(BuildContext context, WidgetRef ref) {
    // Check if user is guest/visitor
    final authState = ref.read(authProvider);
    final user = authState.user;
    final bool isVisitor =
        user?.role_id != 3 &&
        user?.role_id != 4 &&
        user ==
            null; // 3:teacher, 4:student usually, but logically null user or specific check.
    // Actually looking at home_sections.dart logic: if (user?.role_id != 3 && user?.role_id != 4)
    // But simplified: if no user logic or check roles?
    // Let's reuse logic from home_sections:
    // "if (user?.role_id != 3 && user?.role_id != 4) ..."

    // Better logic: if not authenticated or "visitor" role if that exists.
    // The previous code in home_sections used:
    // if (user?.role_id != 3 && user?.role_id != 4)  <-- this seems to mean "if not teacher and not student"? Or "if guest"?
    // Actually in VisitorHomeSection it forces login.
    // Let's assume anyone not logged in (user == null) OR possibly some specific "guest" role?
    // Code in VisitorHomeSection:
    /*
         if (user?.role_id != 3 && user?.role_id != 4) {
              CompleteProfileDialog.show(...)
    */

    // Just copy that logic for consistency.
    // But wait, VisitorHomeSection is specifically for visitors.
    // If this button is used in other places where user MIGHT be logged in, we need to be careful.

    // If user is null -> definitely guest.
    // If user exists: check roles?
    // Let's stick to: if user is logged in (authenticated), allow.
    // The logic in VisitorHomeSection seems to imply that role_id 3 and 4 are the "valid" roles for full access?

    if (isVisitor) {
      CompleteProfileDialog.show(
        context,
        onComplete: () {
          Navigator.pushNamed(context, '/roles');
        },
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TeacherDetailsScreen(teacher: teacher),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = theme ?? Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _showTeacherDetails(context, ref),
        style: ElevatedButton.styleFrom(
          backgroundColor: currentTheme.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: Text(
          AppLocalizations.of(context)!.viewDetailsBook,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
