import 'package:geniuses_school/app_keys.dart';

import 'package:geniuses_school/data/models/course_model.dart';
import 'package:geniuses_school/data/models/payment_request.dart';
import 'package:geniuses_school/data/repositories/course_repository.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/screens/payment/payment_webview_screen.dart';
import 'package:geniuses_school/presentation/state/moyasar_provider.dart';
import 'package:geniuses_school/presentation/widgets/courses/course_stat_card.dart';
import 'package:geniuses_school/presentation/widgets/lessons/teacher_available_times.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CourseDetailsSheet extends ConsumerStatefulWidget {
  final Course course;

  const CourseDetailsSheet({super.key, required this.course});

  @override
  ConsumerState<CourseDetailsSheet> createState() => _CourseDetailsSheetState();
}

class _CourseDetailsSheetState extends ConsumerState<CourseDetailsSheet> {
  late Course course;
  bool _isLoading = false;
  String? _selectedDay;
  String? _selectedTime;
  // BuildContext? _paymentSheetContext; // Removed
  // BuildContext? _cvvDialogContext; // Removed
  // bool _isClosing = false; // Removed or handled by WebView nav

  @override
  void initState() {
    super.initState();
    course = widget.course;
    if (course.availableTimes.isEmpty) {
      // _fetchDetails();
    }
  }

  Future<void> _fetchDetails() async {
    setState(() => _isLoading = true);
    final repo = CourseRepository();
    final detailed = await repo.getCourseDetails(course.id);
    if (detailed != null) {
      if (mounted) {
        setState(() {
          course = detailed;
        });
      }
    }
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Moyasar Payment Listener
    ref.listen<MoyasarState>(moyasarProvider, (previous, next) {
      if (next.status == MoyasarStatus.paymentCreated) {
        if (mounted) {
          final loc = AppLocalizations.of(context)!;
          if (next.paymentId == null || next.paymentId!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('❌ ${loc.invalidCheckoutId}'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          if (next.redirectUrl == null || next.redirectUrl!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('❌ ${loc.invalidPaymentUrl}'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentWebViewScreen(
                amount: double.parse(course.price.toString()),
                currency: 'SAR',
                checkoutId: next.paymentId!,
                redirectUrl: next.redirectUrl!,
                onPaymentComplete: (status) {
                  ref.read(moyasarProvider.notifier).reset();
                  _handlePaymentSuccess();
                },
                onPaymentFailed: (error) {
                  ref.read(moyasarProvider.notifier).reset();
                  if (error == 'user_cancelled') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('⚠️ ${loc.paymentCancelled}'),
                        backgroundColor: Colors.orange,
                        duration: const Duration(seconds: 4),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('❌ ${loc.paymentFailedError(error)}'),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 4),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        }
      }

      if (next.status == MoyasarStatus.error && next.errorMessage != null) {
        final loc = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ ${loc.paymentProcessError(next.errorMessage!)}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });

    final isAlmostFull = course.availableSeats <= 5;

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            height: 4,
            width: 40,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          if (_isLoading) const LinearProgressIndicator(minHeight: 2),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Course Image
                  Stack(
                    children: [
                      Image.network(
                        course.image,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: double.infinity,
                          height: 250,
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.image_not_supported,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade600,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            course.category,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                course.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title & Level
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                course.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _getLevelColor(
                                  course.level,
                                ).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                course.level,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: _getLevelColor(course.level),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Teacher
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person_rounded,
                                color: Colors.blue.shade600,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.instructor,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  course.teacherName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Stats Cards
                        Row(
                          children: [
                            Expanded(
                              child: CourseStatCard(
                                icon: Icons.schedule_rounded,
                                iconColor: Colors.blue.shade600,
                                value: "${course.hours}",
                                label: AppLocalizations.of(
                                  context,
                                )!.trainingHour,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CourseStatCard(
                                icon: Icons.people_rounded,
                                iconColor: Colors.green.shade600,
                                value: "${course.enrolledStudents}",
                                label: AppLocalizations.of(
                                  context,
                                )!.enrolledStudent,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CourseStatCard(
                                icon: Icons.event_seat_rounded,
                                iconColor: isAlmostFull
                                    ? Colors.orange.shade600
                                    : Colors.purple.shade600,
                                value: "${course.availableSeats}",
                                label: AppLocalizations.of(
                                  context,
                                )!.availableSeat,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Price Card
                        if (Theme.of(context).platform != TargetPlatform.iOS)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.green.shade400,
                                  Colors.green.shade600,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.coursePrice,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.certificateIncluded,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "${course.price.toInt()} ${AppLocalizations.of(context)!.sar}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(height: 24),

                        // Description
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.courseDescription,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                course.description,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade700,
                                  height: 1.5,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Topics
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.blue.shade200),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.topic_rounded,
                                    color: Colors.blue.shade600,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    AppLocalizations.of(context)!.coveredTopics,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: course.topics
                                    .map(
                                      (topic) => Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: Colors.blue.shade300,
                                          ),
                                        ),
                                        child: Text(
                                          topic,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.blue.shade700,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Available Times
                        if (course.availableTimes.isNotEmpty) ...[
                          AvailableTimesWidget(
                            availableTimes: course.availableTimes,
                            teacherName: course.teacherName,
                            pricePerHour: course.price,
                            isClickable: false,
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Start Date
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.orange.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today_rounded,
                                color: Colors.orange.shade600,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.startDate,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  Text(
                                    "${course.startDate.day}/${course.startDate.month}/${course.startDate.year}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Enroll Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: (course.availableSeats > 0)
                                ? () {
                                    _showEnrollConfirmation(
                                      context,
                                      day: _selectedDay,
                                      time: _selectedTime,
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                              disabledBackgroundColor: Colors.grey.shade300,
                            ),
                            child: Text(
                              course.availableSeats > 0
                                  ? (Theme.of(context).platform ==
                                            TargetPlatform.iOS
                                        ? AppLocalizations.of(
                                            context,
                                          )!.requestEnrollment
                                        : AppLocalizations.of(
                                            context,
                                          )!.enrollInCourse)
                                  : AppLocalizations.of(context)!.courseFull,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
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
        ],
      ),
    );
  }

  Color _getLevelColor(String level) {
    switch (level) {
      case "مبتدئ":
      case "Beginner":
        return Colors.green;
      case "متوسط":
      case "Intermediate":
        return Colors.orange;
      case "متقدم":
      case "Advanced":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Future<void> _confirmEnrollment() async {
    Navigator.of(context).pop(); // Close confirmation dialog

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      int? slotId;
      if (_selectedDay != null && _selectedTime != null) {
        slotId = course.getSlotId(_selectedDay!, _selectedTime!);
      }

      final repo = CourseRepository();
      final response = await repo.enrollInCourse(
        course.id,
        teacherId: course.teacherId,
        availabilitySlotId: slotId,
      );

      if (mounted) {
        Navigator.of(context).pop(); // Close loading

        final data = response['data'] as Map<String, dynamic>?;
        if (data == null) {
          throw Exception("Invalid response data");
        }

        final bookingId = data['booking_id'] as int?;
        final bookingData = data['booking'] as Map<String, dynamic>?;
        final totalAmount =
            (bookingData?['total_amount'] as num?)?.toInt() ??
            course.price.toInt();

        if (bookingId != null) {
          // Initialize Moyasar Payment
          ref
              .read(moyasarProvider.notifier)
              .initPayment(
                PaymentRequest(
                  amount: double.parse(totalAmount.toString()),
                  currency: 'SAR',
                  merchantTransactionId: 'booking_$bookingId',
                  // No saved card for now, mirroring standard booking
                ),
              );
        } else {
          Navigator.of(context).pop(); // Close details sheet
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(
                  context,
                )!.enrollSuccessMessage(course.title),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().replaceAll("Exception:", "").trim(),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handlePaymentSuccess() {
    if (!mounted) return;
    final loc = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loc.paymentSuccessDefault),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );

    Future.delayed(const Duration(milliseconds: 1000)).then((_) {
      if (mounted) {
        Navigator.of(
          context,
          rootNavigator: true,
        ).pushNamedAndRemoveUntil('/courses', (route) => route.isFirst);
      }
    });
  }

  Future<void> _requestEnrollment() async {
    Navigator.of(context).pop(); // Close confirmation dialog

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final repo = CourseRepository();
      await repo.requestEnrollment(course.id);

      if (mounted) {
        Navigator.of(context).pop(); // Close loading
        Navigator.of(context).pop(); // Close details sheet

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              AppLocalizations.of(context)!.enrollmentRequestTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(
              AppLocalizations.of(context)!.enrollmentRequestSent,
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(AppLocalizations.of(context)!.ok),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop(); // Close loading
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().replaceAll("Exception:", "").trim(),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showEnrollConfirmation(
    BuildContext context, {
    String? day,
    String? time,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            AppLocalizations.of(context)!.confirmEnrollment,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "${AppLocalizations.of(context)!.instructor}: ${course.teacherName}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (day != null && time != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        "${AppLocalizations.of(context)!.time}: $day $time",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      "${AppLocalizations.of(context)!.duration}: ${course.hours} ${AppLocalizations.of(context)!.trainingHour}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    if (Theme.of(context).platform != TargetPlatform.iOS) ...[
                      const SizedBox(height: 12),
                      Text(
                        "${AppLocalizations.of(context)!.totalAmount}: ${course.price.toInt()} ${AppLocalizations.of(context)!.sar}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                AppLocalizations.of(context)!.cancel,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              onPressed: Theme.of(context).platform == TargetPlatform.iOS
                  ? _requestEnrollment
                  : _confirmEnrollment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                Theme.of(context).platform == TargetPlatform.iOS
                    ? AppLocalizations.of(context)!.requestEnrollment
                    : AppLocalizations.of(context)!.confirmEnrollment,
              ),
            ),
          ],
        );
      },
    );
  }
}
