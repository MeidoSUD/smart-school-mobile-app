import 'dart:math';

import 'package:geniuses_school/data/models/booking_model.dart';
import 'package:geniuses_school/data/models/payment_request.dart';
import 'package:geniuses_school/data/models/payment_response_models.dart';
import 'package:geniuses_school/data/repositories/teachers_repository.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/booking_provider.dart';
import 'package:geniuses_school/presentation/state/moyasar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/booking/subject_step.dart';
import '../../widgets/booking/time_step.dart';
import '../payment/payment_webview_screen.dart';
import 'booking_preview_screen.dart';

class BookingFlowScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> teacher;

  const BookingFlowScreen({super.key, required this.teacher});

  @override
  ConsumerState<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends ConsumerState<BookingFlowScreen> {
  int currentStep = 0;
  Map<String, dynamic>? selectedLevel;
  Map<String, dynamic>? selectedClass;
  Map<String, dynamic>? selectedSubject;
  String? selectedDay;
  Map<String, dynamic>? selectedTime;
  String? selectedLessonType = "single";
  int? _selectedSavedCardId;
  String? _selectedBrand;
  int _selectedSessionsCount = 1;

  // Fresh teacher data
  Map<String, dynamic>? _teacherData;
  bool _isLoadingTeacher = true;
  final TeachersRepository _teachersRepo = TeachersRepository();

  @override
  void initState() {
    super.initState();
    _loadTeacherData();
  }

  Future<void> _loadTeacherData() async {
    setState(() {
      _isLoadingTeacher = true;
    });

    try {
      final teacherId = widget.teacher["id"];
      if (teacherId != null) {
        final freshData = await _teachersRepo.getTeacherById(teacherId);
        setState(() {
          _teacherData = freshData;
          _isLoadingTeacher = false;
        });
      } else {
        // Fallback to passed teacher data if no ID
        setState(() {
          _teacherData = widget.teacher;
          _isLoadingTeacher = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingTeacher = false;
        // Fallback to passed teacher data on error
        _teacherData = widget.teacher;
      });
      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.failedToLoadData(e.toString()),
            ),
            backgroundColor: Colors.orange,
            action: SnackBarAction(
              label: AppLocalizations.of(context)!.retry,
              onPressed: _loadTeacherData,
              textColor: Colors.white,
            ),
          ),
        );
      }
    }
  }

  Map<String, dynamic> get _currentTeacher => _teacherData ?? widget.teacher;

  List<Map<String, dynamic>> get availableClasses {
    if (selectedLevel == null) return [];
    return (_currentTeacher["teacher_classes"] as List)
        .where((c) => c["level_id"] == selectedLevel!["id"])
        .cast<Map<String, dynamic>>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    // Show loading state while fetching teacher data
    if (_isLoadingTeacher) {
      return Scaffold(
        appBar: AppBar(
          title: Text(loc.bookLessonTitle),
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(loc.loadingTeacherData),
            ],
          ),
        ),
      );
    }

    // Fix: Use 'single' key check instead of localized string
    final price = selectedLessonType == "single"
        ? _currentTeacher["individual_hour_price"]
        : _currentTeacher["group_hour_price"];

    ref.listen<MoyasarState>(moyasarProvider, (previous, next) {
      if (next.status == MoyasarStatus.paymentCreated) {
        if (mounted) {
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

          if (!next.redirectUrl!.startsWith('https://')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('❌ ${loc.invalidUrl(next.redirectUrl!)}'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PaymentWebViewScreen(
                amount: double.parse(price.toString()),
                currency: 'SAR',
                checkoutId: next.paymentId!,
                redirectUrl: next.redirectUrl!,
                onPaymentComplete: (status) {
                  ref.read(moyasarProvider.notifier).reset();
                  _handlePaymentSuccess(status);
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ ${loc.paymentProcessError(next.errorMessage!)}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });

    ref.listen<AsyncValue<BookState>>(bookingProvider, (previous, next) {
      final value = next.value;
      if (value == null) return;

      if (value.status == BookStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.bookingFailedMessage(value.message)),
            backgroundColor: Colors.red,
          ),
        );
      }

      if (value.status == BookStatus.success) {
        if (mounted) {
          ref
              .read(moyasarProvider.notifier)
              .initPayment(
                PaymentRequest(
                  amount:
                      double.parse(price.toString()) * _selectedSessionsCount,
                  currency: 'SAR',
                  merchantTransactionId: 'booking_${value.bookingId}',
                  savedCardId: _selectedSavedCardId,
                  paymentBrand: _selectedBrand,
                ),
              );
        }
      }
    });

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.pop(context),
          color: theme.primaryColor,
        ),
        title: Text(
          loc.bookLessonTitle,
          style: const TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _loadTeacherData,
            color: theme.primaryColor,
            tooltip: loc.refresh,
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: List.generate(2, (index) {
                final isActive = index <= currentStep;
                final isCompleted = index < currentStep;
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(left: index < 4 ? 8 : 0),
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? theme.primaryColor
                          : isActive
                          ? theme.primaryColor.withOpacity(0.5)
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ),

          // Content
          Expanded(child: _buildCurrentStep()),

          // Navigation Buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                if (currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          currentStep--;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.primaryColor,
                        side: BorderSide(color: theme.primaryColor),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(loc.previous),
                    ),
                  ),
                if (currentStep > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _canProceed() ? _handleNext : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: Text(
                      currentStep == 1 ? loc.confirmBooking : loc.next,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      // case 0:
      //   return _buildLessonTypeStep();
      case 0:
        return _buildSubjectStep();
      case 1:
        return _buildTimeStep();
      default:
        return Container();
    }
  }

  // Widget _buildLessonTypeStep() {
  //   return LessonTypeStep(
  //     teacher: widget.teacher,
  //     selectedLessonType: selectedLessonType,
  //     onLessonTypeSelected: (type) {
  //       setState(() {
  //         selectedLessonType = type;
  //       });
  //     },
  //   );
  // }

  Widget _buildSubjectStep() {
    var subjects = widget.teacher["teacher_subjects"] as List? ?? [];

    if (subjects.isEmpty) {
      final languages = widget.teacher["languages"] as List? ?? [];
      if (languages.isNotEmpty) {
        final isAr = Localizations.localeOf(context).languageCode == 'ar';
        subjects = languages.map((l) {
          return {
            "id": l["id"],
            "subject_id": l["language_id"],
            "title": isAr
                ? (l["name_ar"] ?? l["name_en"] ?? "")
                : (l["name_en"] ?? l["name_ar"] ?? ""),
          };
        }).toList();
      }
    }

    return SubjectStep(
      subjects: subjects,
      selectedSubject: selectedSubject,
      onSubjectSelected: (subject) {
        setState(() {
          selectedSubject = subject;
        });
      },
    );
  }

  Widget _buildTimeStep() {
    return TimeStep(
      availableTimes: _currentTeacher["available_times"] as List? ?? [],
      selectedDay: selectedDay,
      selectedTime: selectedTime,
      onTimeSelected: (day, timeData) {
        setState(() {
          selectedDay = day;
          selectedTime = timeData;
        });
      },
    );
  }

  _canProceed() {
    switch (currentStep) {
      // case 0:
      //   return selectedLessonType != null;
      case 0:
        return selectedSubject != null;
      case 1:
        return selectedDay != null && selectedTime != null;
      default:
        return false;
    }
  }

  void _handleNext() {
    if (currentStep < 1) {
      setState(() {
        currentStep++;
      });
    } else {
      _showBookingPreview();
    }
  }

  void _showBookingPreview() {
    // Fix: Use 'single' key check
    final price = selectedLessonType == "single"
        ? widget.teacher["individual_hour_price"]
        : widget.teacher["group_hour_price"];

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (paymentContext) => BookingPreviewScreen(
          bookingDetails: {
            'lessonType': selectedLessonType, // 'single' or 'group'
            'level': selectedLevel?["title"],
            'className': selectedClass?["title"],
            'subject': selectedSubject?["title"],
            'day': selectedDay,
            'time': selectedTime?["time"],
          },
          price: price.toString(),
          teacherName:
              "${widget.teacher["first_name"]} ${widget.teacher["last_name"]}",
          teacherImage: widget.teacher["profile_image"],
          onConfirm: (savedCardId, brand, totalSessions) async {
            setState(() {
              _selectedSavedCardId = savedCardId;
              // START FIX: Set brand BEFORE booking action so it's available for the listener
              _selectedBrand = brand;
              // END FIX
              _selectedSessionsCount = totalSessions;
            });

            final bookingNotifier = ref.read(bookingProvider.notifier);
            await bookingNotifier.addBooking(
              BookingModel(
                id: Random().nextInt(100000),
                teacherId: widget.teacher["id"],
                timeSlotId: selectedTime?["id"],
                lessonType: selectedLessonType == "single" ? "single" : "group",
                subjectId: selectedSubject?["subject_id"],
                serviceId: _getServiceId(),
                totalSessions: totalSessions,
              ),
            );
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  int _getServiceId() {
    // If it's a language booking (has language_id in subject), use language service (ID 2)
    // You can also look up from teacher services list if needed for more robustness
    if (selectedSubject != null && selectedSubject!.containsKey("subject_id")) {
      // Check if this subject is actually a language
      // In _buildSubjectStep we mapped languages: "subject_id": l["language_id"]

      final isLanguage = (widget.teacher["languages"] as List? ?? []).any(
        (l) => l["language_id"] == selectedSubject!["subject_id"],
      );

      if (isLanguage) {
        // Try to find the exact service ID for languages from the teacher's service list
        final services = widget.teacher["services"] as List?;
        if (services != null) {
          // Fix: Use a safer way to find the service to avoid type mismatch in orElse
          for (var s in services) {
            if (s is Map && (s["id"] == 2 || s["key_name"] == "languages")) {
              return s["id"] as int;
            }
          }
        }
        return 2; // Fallback to 2 for languages
      }
    }

    // Default fallback
    return widget.teacher["service_id"] ?? 3;
  }

  void _handlePaymentSuccess(PaymentStatusResponse result) {
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
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    });
  }
}
