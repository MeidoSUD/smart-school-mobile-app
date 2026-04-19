import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/available_times.dart';
import '../../data/models/time_slot.dart';
import '../../data/repositories/available_times_repository.dart';

// StateNotifier for managing available times with state
class AvailableTimesNotifier
    extends StateNotifier<AsyncValue<List<AvailableTimes>>> {
  final AvailableTimesRepository _repository;
  
  // Track deleted slot IDs to sync with backend
  final List<int> _deletedSlotIds = [];

  AvailableTimesNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadAvailableTimes();
  }

  Future<void> loadAvailableTimes() async {
    state = const AsyncValue.loading();
    try {
      final times = await _repository.getAvailableTimes();
      state = AsyncValue.data(times);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  // Add a time slot to a specific day
  void addTimeSlot(int dayId, TimeSlot newSlot) {
    state.whenData((availableTimes) {
      final updatedTimes = availableTimes.map((dayData) {
        if (dayData.day == dayId) {
          // Add the new slot and sort by time
          final updatedSlots = [...dayData.timeSlots, newSlot];
          updatedSlots.sort((a, b) {
            final aMinutes = a.time.hour * 60 + a.time.minute;
            final bMinutes = b.time.hour * 60 + b.time.minute;
            return aMinutes.compareTo(bMinutes);
          });
          return dayData.copyWith(timeSlots: updatedSlots);
        }
        return dayData;
      }).toList();

      // If the day doesn't exist, create it
      if (!availableTimes.any((d) => d.day == dayId)) {
        updatedTimes.add(AvailableTimes(day: dayId, timeSlots: [newSlot]));
        updatedTimes.sort((a, b) => a.day.compareTo(b.day));
      }

      state = AsyncValue.data(updatedTimes);
    });
  }

  // Remove a time slot from a specific day
  void removeTimeSlot(int dayId, TimeSlot slotToRemove) {
    state.whenData((availableTimes) {
      final updatedTimes = availableTimes.map((dayData) {
        if (dayData.day == dayId) {
          final updatedSlots = dayData.timeSlots
              .where((slot) => slot.id != slotToRemove.id)
              .toList();
          return dayData.copyWith(timeSlots: updatedSlots);
        }
        return dayData;
      }).toList();

      // Add to deleted IDs list if ID > 0 (existing slot from backend)
      // Negative IDs are new slots that haven't been saved yet
      if (slotToRemove.id > 0 && !_deletedSlotIds.contains(slotToRemove.id)) {
        _deletedSlotIds.add(slotToRemove.id);
      }

      state = AsyncValue.data(updatedTimes);
    });
  }

  // Update a specific time slot (e.g., assign a lesson)
  void updateTimeSlot(int dayId, TimeSlot updatedSlot) {
    state.whenData((availableTimes) {
      final updatedTimes = availableTimes.map((dayData) {
        if (dayData.day == dayId) {
          final updatedSlots = dayData.timeSlots.map((slot) {
            return slot.id == updatedSlot.id ? updatedSlot : slot;
          }).toList();
          return dayData.copyWith(timeSlots: updatedSlots);
        }
        return dayData;
      }).toList();

      state = AsyncValue.data(updatedTimes);
    });
  }

  // Cancel a lesson (set lesson to null)
  void cancelLesson(int dayId, int slotId) {
    state.whenData((availableTimes) {
      final updatedTimes = availableTimes.map((dayData) {
        if (dayData.day == dayId) {
          final updatedSlots = dayData.timeSlots.map((slot) {
            if (slot.id == slotId) {
              return TimeSlot(id: slot.id, time: slot.time, session: null);
            }
            return slot;
          }).toList();
          return dayData.copyWith(timeSlots: updatedSlots);
        }
        return dayData;
      }).toList();

      state = AsyncValue.data(updatedTimes);
    });
  }

  // Save changes to the backend
  Future<void> saveChanges(BuildContext context) async {
    // ✅ Save current state before changing it
    final previous = state.value;

    state = const AsyncValue.loading();

    try {
      // Step 1: Delete removed slots if any
      if (_deletedSlotIds.isNotEmpty) {
        if (kDebugMode) {
          debugPrint("Deleting slots: $_deletedSlotIds");
        }
        await _repository.deleteAvailableTimesBatch(List.from(_deletedSlotIds));
        _deletedSlotIds.clear();
      }

      // Step 2: Add new slots (only those with temporary IDs or no ID)
      final availableTimes = previous ?? [];
      final newSlots = <Map<String, dynamic>>[];
      
      for (final dayData in availableTimes) {
        final times = dayData.timeSlots
            .where((slot) => slot.id <= 0 || slot.id == null) // Only new slots
            .map((slot) => slot.time.format(context))
            .toList();
        
        if (times.isNotEmpty) {
          newSlots.add({
            "day": dayData.day,
            "times": times,
          });
        }
      }

      if (newSlots.isNotEmpty) {
        if (kDebugMode) {
          debugPrint("Adding new slots: $newSlots");
        }
        final requestBody = {
          "available_times": newSlots,
        };
        await _repository.updateAvailableTimes(requestBody);
      }

      if (kDebugMode) {
        debugPrint("Save successful");
      }

      // Reload to get updated IDs from backend
      await loadAvailableTimes();
    } catch (error, st) {
      if (kDebugMode) {
        debugPrint("Error saving: $error");
      }
      state = AsyncValue.error(error, st);
    }
  }
}

// Provider definitions
final availableTimesRepositoryProvider = Provider(
  (ref) => AvailableTimesRepository(),
);

final availableTimesProvider =
    StateNotifierProvider<
      AvailableTimesNotifier,
      AsyncValue<List<AvailableTimes>>
    >((ref) {
      final repository = ref.watch(availableTimesRepositoryProvider);
      return AvailableTimesNotifier(repository);
    });
