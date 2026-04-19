import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class AvailableTimesWidget extends StatelessWidget {
  final Map<String, List<String>> availableTimes;
  final String teacherName;
  final double pricePerHour;
  final Function(String day, String time)? onTimeTap;
  final String? selectedDay;
  final String? selectedTime;
  final bool isClickable;

  const AvailableTimesWidget({
    super.key,
    required this.availableTimes,
    required this.teacherName,
    required this.pricePerHour,
    this.onTimeTap,
    this.selectedDay,
    this.selectedTime,
    this.isClickable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                color: Colors.orange.shade600,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)!.availableBookingTimes,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          ...availableTimes.entries.map((entry) {
            final day = entry.key;
            final times = entry.value;

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange.shade700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: times
                        .map(
                          (time) => _TimeSlotChip(
                            time: time,
                            day: day,
                            teacherName: teacherName,
                            pricePerHour: pricePerHour,
                            onTap: onTimeTap,
                            isSelected:
                                selectedDay == day && selectedTime == time,
                            isClickable: isClickable,
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// Time Slot Chip Widget
class _TimeSlotChip extends StatelessWidget {
  final String time;
  final String day;
  final String teacherName;
  final double pricePerHour;
  final Function(String day, String time)? onTap;
  final bool isSelected;
  final bool isClickable;

  const _TimeSlotChip({
    required this.time,
    required this.day,
    required this.teacherName,
    required this.pricePerHour,
    this.onTap,
    this.isSelected = false,
    this.isClickable = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isClickable
          ? () {
              if (onTap != null) {
                onTap!(day, time);
              } else {
                _showBookingConfirmation(context);
              }
            }
          : null,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade600 : Colors.green.shade50,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.green.shade700 : Colors.green.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 16,
              color: isSelected ? Colors.white : Colors.green.shade700,
            ),
            const SizedBox(width: 6),
            Text(
              time,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.green.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            AppLocalizations.of(context)!.confirmBooking,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
                      "${AppLocalizations.of(context)!.teacher}: $teacherName",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${AppLocalizations.of(context)!.today}: $day",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${AppLocalizations.of(context)!.time}: $time",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (Theme.of(context).platform != TargetPlatform.iOS) ...[
                      const SizedBox(height: 8),
                      Text(
                        "${AppLocalizations.of(context)!.price}: ${pricePerHour.toInt()} ${AppLocalizations.of(context)!.currency}/${AppLocalizations.of(context)!.hour}",
                        style: TextStyle(
                          fontSize: 16,
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
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Close teacher details sheet
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(
                        context,
                      )!.bookingConfirmedMsg(teacherName, day, time),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.green,
                    duration: const Duration(seconds: 3),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.confirmBooking),
            ),
          ],
        );
      },
    );
  }
}
