import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialService {
  static const String _tutorialShownPrefix = 'tutorial_shown_';
  static const String teacherHomeTutorialId = 'teacher_home';
  static const String teacherSessionsTutorialId = 'teacher_sessions';
  static const String teacherProfileTutorialId = 'teacher_profile';
  static const String studentHomeTutorialId = 'student_home';

  static Future<bool> hasShownTutorial(String tutorialId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_tutorialShownPrefix$tutorialId') ?? false;
  }

  static Future<void> markTutorialShown(String tutorialId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_tutorialShownPrefix$tutorialId', true);
  }

  static Future<void> scrollTo(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) return;

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOut,
      alignment: 0.5,
    );
    await Future.delayed(const Duration(milliseconds: 180));
  }

  static Future<void> startGuidedTour({
    required BuildContext context,
    required List<Map<String, dynamic>> tourSteps,
    String? tutorialId,
    bool markAsShown = true,
  }) async {
    if (tourSteps.isEmpty) return;

    final validSteps = tourSteps
        .where((step) => (step['key'] as GlobalKey?)?.currentContext != null)
        .toList();
    if (validSteps.isEmpty) return;

    await scrollTo(validSteps.first['key'] as GlobalKey);
    if (!context.mounted) return;

    final List<TargetFocus> targets = [];

    for (int i = 0; i < validSteps.length; i++) {
      final step = validSteps[i];
      final isLast = i == validSteps.length - 1;
      final nextStep = isLast ? null : validSteps[i + 1];

      targets.add(
        TargetFocus(
          identify: 'tutorial_target_$i',
          keyTarget: step['key'] as GlobalKey,
          alignSkip: Alignment.topRight,
          shape: ShapeLightFocus.RRect,
          radius: 10,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              builder: (context, controller) {
                return _buildTooltip(
                  context: context,
                  title: step['title'] as String,
                  description: step['description'] as String,
                  currentStep: i + 1,
                  totalSteps: validSteps.length,
                  isLast: isLast,
                  onNext: () async {
                    if (isLast) {
                      controller.skip();
                    } else {
                      await scrollTo(nextStep!['key'] as GlobalKey);
                      controller.next();
                    }
                  },
                  onSkip: () => controller.skip(),
                );
              },
            ),
          ],
        ),
      );
    }

    TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black.withValues(alpha: 0.7),
      opacityShadow: 0.7,
      hideSkip: true,
      onFinish: () {
        if (tutorialId != null && markAsShown) {
          unawaited(markTutorialShown(tutorialId));
        }
      },
      onSkip: () {
        if (tutorialId != null && markAsShown) {
          unawaited(markTutorialShown(tutorialId));
        }
        return true;
      },
    ).show(context: context);
  }

  static Widget _buildTooltip({
    required BuildContext context,
    required String title,
    required String description,
    required int currentStep,
    required int totalSteps,
    required bool isLast,
    required VoidCallback onSkip,
    required VoidCallback onNext,
  }) {
    final primaryColor = Theme.of(context).primaryColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          size: const Size(18, 9),
          painter: _TooltipArrowPainter(color: Colors.white),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.86,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$currentStep/$totalSteps',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onSkip,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.close, size: 18, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: onSkip, child: const Text('تخطي')),
                  ElevatedButton(
                    onPressed: onNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                    ),
                    child: Text(isLast ? 'إنهاء' : 'التالي'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TooltipArrowPainter extends CustomPainter {
  final Color color;

  const _TooltipArrowPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TooltipArrowPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
