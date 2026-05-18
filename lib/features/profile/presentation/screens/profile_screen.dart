import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/localization/generated/locale_keys.g.dart';
import '../bloc/profile_cubit.dart';
import '../bloc/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<ProfileCubit>()..loadProfile(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.profile_title)),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (profile) {
                final name = profile['name'] as String? ?? '';
                final email = profile['email'] as String? ?? '';
                final phone = profile['phone'] as String? ?? '';
                final studentClass = profile['class'] as String? ?? '';
                final section = profile['section'] as String? ?? '';
                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 48.r,
                        backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
                        child: Icon(Icons.person, size: 48.sp, color: theme.colorScheme.primary),
                      ),
                      SizedBox(height: 12.h),
                      Text(name, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
                      if (studentClass.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text('$studentClass $section', style: TextStyle(fontSize: 14.sp, color: Colors.grey[600])),
                      ],
                      SizedBox(height: 24.h),
                      _InfoTile(icon: Icons.email_outlined, label: context.tr(LocaleKeys.profile_email), value: email),
                      _InfoTile(icon: Icons.phone_outlined, label: context.tr(LocaleKeys.profile_phone), value: phone),
                    ],
                  ),
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

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
        subtitle: Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
