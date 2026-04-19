import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Reusable Complete Profile Dialog
/// Shows a professional dialog prompting users to complete their profile
class CompleteProfileDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final List<RequirementItem>? requirements;
  final VoidCallback onComplete;
  final VoidCallback? onDismiss;
  final String? completeButtonText;
  final String? dismissButtonText;
  final bool barrierDismissible;

  const CompleteProfileDialog({
    super.key,
    this.title,
    this.message,
    this.requirements,
    required this.onComplete,
    this.onDismiss,
    this.completeButtonText,
    this.dismissButtonText,
    this.barrierDismissible = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(theme, context),
            _buildContent(theme, context),
            _buildActions(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor, theme.primaryColor.withOpacity(0.8)],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title ?? AppLocalizations.of(context)!.completeProfile,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(ThemeData theme, BuildContext context) {
    final effectiveRequirements =
        requirements ??
        [
          RequirementItem(
            icon: Icons.badge_outlined,
            text: AppLocalizations.of(context)!.selectRoleReq,
          ),
          RequirementItem(
            icon: Icons.info_outline,
            text: AppLocalizations.of(context)!.basicInfoReq,
          ),
          RequirementItem(
            icon: Icons.verified_user_outlined,
            text: AppLocalizations.of(context)!.verifyAccountReq,
          ),
        ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            message ?? AppLocalizations.of(context)!.completeProfileMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          ...effectiveRequirements.map(
            (req) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildRequirementItem(req, theme),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementItem(RequirementItem item, ThemeData theme) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(item.icon, size: 20, color: theme.primaryColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            item.text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Icon(Icons.chevron_left, size: 20, color: Colors.grey[400]),
      ],
    );
  }

  Widget _buildActions(BuildContext context, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onComplete();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                completeButtonText ??
                    AppLocalizations.of(context)!.completeProfileButton,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
                onDismiss?.call();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                dismissButtonText ?? AppLocalizations.of(context)!.later,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Static method to show the dialog easily
  static Future<void> show(
    BuildContext context, {
    String? title,
    String? message,
    List<RequirementItem>? requirements,
    required VoidCallback onComplete,
    VoidCallback? onDismiss,
    String? completeButtonText,
    String? dismissButtonText,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => CompleteProfileDialog(
        title: title,
        message: message,
        requirements: requirements,
        onComplete: onComplete,
        onDismiss: onDismiss,
        completeButtonText: completeButtonText,
        dismissButtonText: dismissButtonText,
        barrierDismissible: barrierDismissible,
      ),
    );
  }
}

/// Model for requirement items in the dialog
class RequirementItem {
  final IconData icon;
  final String text;

  RequirementItem({required this.icon, required this.text});
}

// ============================================================
// USAGE EXAMPLES
// ============================================================

/* 
// Example 1: Using the static show method (Recommended - Simplest)
CompleteProfileDialog.show(
  context,
  onComplete: () {
    Navigator.pushNamed(context, '/complete-profile');
  },
  onDismiss: () {
    print('User dismissed dialog');
  },
);

// Example 2: With custom requirements
CompleteProfileDialog.show(
  context,
  title: AppLocalizations.of(context)!.completeProfileTitle,
  message: AppLocalizations.of(context)!.completeProfileMessage,
  requirements: [
    RequirementItem(
      icon: Icons.email_outlined,
      text: AppLocalizations.of(context)!.confirmEmailAction,
    ),
    RequirementItem(
      icon: Icons.phone_outlined,
      text: AppLocalizations.of(context)!.addPhoneAction,
    ),
    RequirementItem(
      icon: Icons.photo_camera_outlined,
      text: AppLocalizations.of(context)!.uploadPhotoAction,
    ),
  ],
  onComplete: () {
    Navigator.pushNamed(context, '/profile-setup');
  },
  completeButtonText: AppLocalizations.of(context)!.completeNowButton,
  dismissButtonText: AppLocalizations.of(context)!.cancelButton,
);

// Example 3: Your specific use case
onViewAll: () {
  if (user!.role_id != 2 && user!.role_id != 1) {
    CompleteProfileDialog.show(
      context,
      onComplete: () {
        Navigator.pushNamed(context, '/complete-profile');
      },
    );
  } else {
    Navigator.pushNamed(context, "/lessons");
  }
}

// Example 4: Using the widget directly with showDialog
onTap: () {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => CompleteProfileDialog(
      title: AppLocalizations.of(context)!.updateProfileTitle,
      message: AppLocalizations.of(context)!.updateProfileMessage,
      requirements: [
        RequirementItem(
          icon: Icons.school,
          text: AppLocalizations.of(context)!.selectEducationLevel,
        ),
        RequirementItem(
          icon: Icons.location_on,
          text: AppLocalizations.of(context)!.addLocationAction,
        ),
      ],
      onComplete: () {
        Navigator.pushNamed(context, '/update-profile');
      },
      onDismiss: () {
        // Optional dismiss handler
        print('Dialog dismissed');
      },
    ),
  );
}

// Example 5: Multiple conditions check
void navigateToFeature() {
  if (!user.isEmailVerified) {
    CompleteProfileDialog.show(
      context,
      title: AppLocalizations.of(context)!.emailConfirmationTitle,
      message: AppLocalizations.of(context)!.emailConfirmationMessage,
      requirements: [
        RequirementItem(
          icon: Icons.mark_email_read_outlined,
          text: AppLocalizations.of(context)!.openEmailApp,
        ),
        RequirementItem(
          icon: Icons.link,
          text: AppLocalizations.of(context)!.clickConfirmationLink,
        ),
      ],
      onComplete: () {
        // Send verification email
        sendVerificationEmail();
      },
    );
  } else if (user.role_id == null) {
    CompleteProfileDialog.show(
      context,
      onComplete: () {
        Navigator.pushNamed(context, '/select-role');
      },
    );
  } else {
    Navigator.pushNamed(context, '/feature');
  }
}

// Example 6: With different button texts
CompleteProfileDialog.show(
  context,
  title: AppLocalizations.of(context)!.subscriptionRequired,
  message: AppLocalizations.of(context)!.subscriptionMessage,
  requirements: [
    RequirementItem(
      icon: Icons.workspace_premium,
      text: AppLocalizations.of(context)!.subscribePremium,
    ),
    RequirementItem(
      icon: Icons.featured_play_list,
      text: AppLocalizations.of(context)!.exclusiveFeatures,
    ),
  ],
  onComplete: () {
    Navigator.pushNamed(context, '/subscription');
  },
  completeButtonText: AppLocalizations.of(context)!.subscribeNow,
  dismissButtonText: AppLocalizations.of(context)!.goBack,
  barrierDismissible: true,
);
*/
