import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/available_times.dart';
import '../../../data/models/time_slot.dart';
import '../../state/available_times_provider.dart';
import '../../state/lessons_provider.dart';
import '../../widgets/common/available_times_shummer_widget.dart';
import '../../widgets/common/error_screen_widget.dart';
import '../../widgets/schedule/add_time_dialog.dart';
import '../../widgets/schedule/available_slot_card.dart';
import '../../widgets/schedule/days_selector.dart';
import '../../widgets/schedule/schedule_empty_state.dart';
import '../../widgets/schedule/schedule_header.dart';
import '../../widgets/schedule/schedule_stat_card.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends ConsumerState<ScheduleScreen>
    with TickerProviderStateMixin {
  int selectedDayIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<WeekDay> get days {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) {
      return [
        WeekDay(id: 1, englishName: "saturday", arabicName: "Saturday"),
        WeekDay(id: 2, englishName: "sunday", arabicName: "Sunday"),
        WeekDay(id: 3, englishName: "monday", arabicName: "Monday"),
        WeekDay(id: 4, englishName: "tuesday", arabicName: "Tuesday"),
        WeekDay(id: 5, englishName: "wednesday", arabicName: "Wednesday"),
        WeekDay(id: 6, englishName: "thursday", arabicName: "Thursday"),
        WeekDay(id: 7, englishName: "friday", arabicName: "Friday"),
      ];
    }
    return [
      WeekDay(id: 1, englishName: "saturday", arabicName: l10n.saturday),
      WeekDay(id: 2, englishName: "sunday", arabicName: l10n.sunday),
      WeekDay(id: 3, englishName: "monday", arabicName: l10n.monday),
      WeekDay(id: 4, englishName: "tuesday", arabicName: l10n.tuesday),
      WeekDay(id: 5, englishName: "wednesday", arabicName: l10n.wednesday),
      WeekDay(id: 6, englishName: "thursday", arabicName: l10n.thursday),
      WeekDay(id: 7, englishName: "friday", arabicName: l10n.friday),
    ];
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<TimeSlot> get currentDaySchedule {
    final availableTimesState = ref.watch(availableTimesProvider);
    final lessonsState = ref.watch(lessonsProvider);

    List<TimeSlot> slots = [];

    // Add available slots
    availableTimesState.maybeWhen(
      data: (data) {
        final dayData = data.firstWhere(
          (item) => item.day == days[selectedDayIndex].id,
          orElse: () =>
              AvailableTimes(day: days[selectedDayIndex].id, timeSlots: []),
        );
        slots.addAll(dayData.timeSlots);
      },
      orElse: () {},
    );

    // Sort by time
    slots.sort((a, b) {
      int aMin = a.time.hour * 60 + a.time.minute;
      int bMin = b.time.hour * 60 + b.time.minute;
      return aMin.compareTo(bMin);
    });

    return slots;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final availableTimeState = ref.watch(availableTimesProvider);
    final l10n = AppLocalizations.of(context)!;

    return availableTimeState.when(
      data: (data) => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: _buildAppBar(theme, l10n),
        body: Column(
          children: [
            DaysSelector(
              days: days,
              selectedDayIndex: selectedDayIndex,
              onDaySelected: (index) {
                setState(() {
                  selectedDayIndex = index;
                });
                _animationController.reset();
                _animationController.forward();
              },
              timeState: data,
            ),
            ScheduleHeader(
              dayName: days[selectedDayIndex].arabicName,
              count: currentDaySchedule.length,
            ),
            Expanded(child: _buildScheduleList(theme, l10n)),
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(theme, l10n),
      ),
      loading: () => const AvailableTimesShimmerWidget(),
      error: (err, stack) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.errorLabel(err.toString()),
              ),
            ),
          );
        });
        return ErrorScreenWidget(
          message: err.toString(),
        ); // Return an empty widget
      },
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme, AppLocalizations l10n) {
    final totalSlots = currentDaySchedule.length;
    final occupiedSlots = currentDaySchedule
        .where((slot) => slot.isAvailable == false)
        .length;

    return AppBar(
      title: Text(
        l10n.availableTimesTitle,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      backgroundColor: theme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ScheduleStatCard(
                title: l10n.total,
                value: totalSlots.toString(),
                icon: Icons.schedule,
              ),
              ScheduleStatCard(
                title: l10n.booked,
                value: occupiedSlots.toString(),
                icon: Icons.event_busy,
              ),
              ScheduleStatCard(
                title: l10n.available,
                value: (totalSlots - occupiedSlots).toString(),
                icon: Icons.event_available,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleList(ThemeData theme, AppLocalizations l10n) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: RefreshIndicator(
        onRefresh: () =>
            ref.read(availableTimesProvider.notifier).loadAvailableTimes(),
        child: currentDaySchedule.isEmpty
            ? const SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SizedBox(height: 400, child: ScheduleEmptyState()),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: currentDaySchedule.length,
                itemBuilder: (context, index) {
                  final slot = currentDaySchedule[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AvailableSlotCard(slot: slot, onRemove: _removeSlot),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildFloatingActionButton(ThemeData theme, AppLocalizations l10n) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton.extended(
          onPressed: () => _showAddTimeDialog(theme),
          backgroundColor: theme.primaryColor,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add),
          label: Text(l10n.addTime),
        ),
        const SizedBox(width: 12),
        FloatingActionButton.extended(
          onPressed: () {
            ref.read(availableTimesProvider.notifier).saveChanges(context).then(
              (_) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.changesSaved),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            );
          },
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.save),
          label: Text(l10n.save),
        ),
      ],
    );
  }

  void _showAddTimeDialog(ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AddTimeDialog(
        dayName: days[selectedDayIndex].arabicName,
        onAdd: _addTimeSlot,
      ),
    );
  }

  void _addTimeSlot(TimeOfDay time) {
    final dayId = days[selectedDayIndex].id;
    final l10n = AppLocalizations.of(context)!;

    // Check if the selected time already exists
    final availableTimes = ref.read(availableTimesProvider).value ?? [];
    final dayData = availableTimes.firstWhere(
      (item) => item.day == dayId,
      orElse: () => AvailableTimes(day: dayId, timeSlots: []),
    );

    final isTimeExists = dayData.timeSlots.any(
      (slot) =>
          slot.time.hour == time.hour ||
          (slot.time.hour == time.hour - 1 && time.minute < 30) ||
          (slot.time.hour == time.hour + 1 && time.minute >= 30),
    );

    if (isTimeExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.timeExistsError(time.format(context))),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Generate a unique negative ID for the new slot
    // Negative IDs indicate new slots that need to be created on backend
    int minId = 0;
    for (var dayData in availableTimes) {
      for (var slot in dayData.timeSlots) {
        if (slot.id < minId) minId = slot.id;
      }
    }

    final newSlot = TimeSlot(id: minId - 1, time: time, session: null);

    // Add the slot using the notifier
    ref.read(availableTimesProvider.notifier).addTimeSlot(dayId, newSlot);

    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(l10n.timeAddedSuccess(time.format(context))),
    //     backgroundColor: Colors.green,
    //   ),
    // );
  }

  void _removeSlot(TimeSlot slot) {
    final dayId = days[selectedDayIndex].id;
    final l10n = AppLocalizations.of(context)!;

    // Remove the slot using the notifier
    ref.read(availableTimesProvider.notifier).removeTimeSlot(dayId, slot);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.timeRemovedSuccess(slot.time.format(context))),
        backgroundColor: Colors.orange,
      ),
    );
  }
}
