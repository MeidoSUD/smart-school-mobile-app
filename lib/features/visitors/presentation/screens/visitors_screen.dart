import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';
import '../bloc/visitors_cubit.dart';
import '../bloc/visitors_state.dart';

class VisitorsScreen extends StatelessWidget {
  const VisitorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<VisitorsCubit>()..loadVisitors(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.visitors_title)),
        ),
        body: BlocBuilder<VisitorsCubit, VisitorsState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (visitors) {
                if (visitors.isEmpty) {
                  return Center(child: Text(context.tr(LocaleKeys.common_no_data)));
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: visitors.length,
                  itemBuilder: (context, index) {
                    final v = visitors[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12.w),
                        leading: CircleAvatar(
                          backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                          child: Text(v.name.isNotEmpty ? v.name[0].toUpperCase() : '?',
                              style: TextStyle(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
                        ),
                        title: Text(v.name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (v.reason != null) Text(v.reason!, style: TextStyle(fontSize: 12.sp)),
                            if (v.visitDate != null) Text(v.visitDate!, style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                          ],
                        ),
                        trailing: v.phone != null ? Text(v.phone!, style: TextStyle(fontSize: 11.sp, color: Colors.grey[600])) : null,
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
