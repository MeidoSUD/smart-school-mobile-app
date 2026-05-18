import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';
import '../bloc/hostel_cubit.dart';
import '../bloc/hostel_state.dart';

class HostelScreen extends StatelessWidget {
  const HostelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<HostelCubit>()..loadHostelInfo(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.hostel_title)),
        ),
        body: BlocBuilder<HostelCubit, HostelState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (hostels) {
                if (hostels.isEmpty) {
                  return Center(child: Text(context.tr(LocaleKeys.common_no_data)));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: hostels.length,
                  itemBuilder: (context, index) {
                    final h = hostels[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.meeting_room, color: theme.colorScheme.primary),
                                SizedBox(width: 8.w),
                                Text(h.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                _InfoChip(label: '${context.tr(LocaleKeys.hostel_room_number)}: ${h.roomNumber ?? '-'}'),
                                SizedBox(width: 8.w),
                                _InfoChip(label: '${context.tr(LocaleKeys.hostel_block)}: ${h.block ?? '-'}'),
                                SizedBox(width: 8.w),
                                _InfoChip(label: '${context.tr(LocaleKeys.hostel_bed_number)}: ${h.bedNumber ?? '-'}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              error: (message) => Center(child: Text(message)),
            );
          },
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(label, style: TextStyle(fontSize: 11.sp, color: Colors.grey[700])),
    );
  }
}
