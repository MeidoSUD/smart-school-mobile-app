import 'package:geniuses_school/data/models/available_times.dart';
import 'package:geniuses_school/data/models/time_slot.dart';
import 'package:flutter/material.dart';

class WeekDay {
  final int id;
  final String englishName;
  final String arabicName;

  WeekDay({
    required this.id,
    required this.englishName,
    required this.arabicName,
  });
}

class DaysSelector extends StatelessWidget {
  final List<WeekDay> days;
  final int selectedDayIndex;
  final Function(int) onDaySelected;
  final List<AvailableTimes> timeState;

  const DaysSelector({
    super.key,
    required this.days,
    required this.selectedDayIndex,
    required this.onDaySelected,
    required this.timeState,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected = selectedDayIndex == index;
          final daySchedule = (timeState.firstWhere(
            (item) => item.day == day.id,
            orElse: () => AvailableTimes(day: day.id, timeSlots: []),
          )).timeSlots;
          final hasLessons = daySchedule.any(
            (TimeSlot slot) => slot.session != null,
          );

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: GestureDetector(
              onTap: () => onDaySelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 80,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                  border: isSelected
                      ? null
                      : Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      day.arabicName,
                      style: TextStyle(
                        color: isSelected ? theme.primaryColor : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 20,
                      height: 4,
                      decoration: BoxDecoration(
                        color: hasLessons
                            ? (isSelected ? Colors.orange : Colors.white)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${daySchedule.length}",
                      style: TextStyle(
                        color: isSelected ? theme.primaryColor : Colors.white70,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
