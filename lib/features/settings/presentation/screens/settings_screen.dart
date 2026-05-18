import '../../../../core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsCubit = context.watch<SettingsCubit>();

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(4.w, 48.h, 4.w, 16.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [theme.colorScheme.primary, theme.colorScheme.primary.withValues(alpha: 0.75)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28.r),
                bottomRight: Radius.circular(28.r),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 20.sp),
                  onPressed: () => Navigator.pop(context),
                ),
                Text(
                  context.tr(LocaleKeys.settings_title),
                  style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(Icons.settings, color: Colors.white, size: 20.sp),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                _SectionLabel(label: context.tr(LocaleKeys.settings_notifications)),
                SizedBox(height: 8.h),
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: context.tr(LocaleKeys.settings_notifications),
                  trailing: Switch.adaptive(
                    value: true,
                    onChanged: (_) {},
                  ),
                ),
                SizedBox(height: 20.h),
                _SectionLabel(label: context.tr(LocaleKeys.settings_language)),
                SizedBox(height: 8.h),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 40.w, height: 40.w,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Icon(Icons.language, color: theme.colorScheme.primary, size: 20.sp),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(context.tr(LocaleKeys.settings_language),
                                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: _LangButton(
                                label: 'English',
                                selected: settingsCubit.state.locale == 'en',
                                onTap: () {
                                  settingsCubit.setLocale('en');
                                  context.setLocale(const Locale('en'));
                                },
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: _LangButton(
                                label: 'العربية',
                                selected: settingsCubit.state.locale == 'ar',
                                onTap: () {
                                  settingsCubit.setLocale('ar');
                                  context.setLocale(const Locale('ar'));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                _SectionLabel(label: context.tr(LocaleKeys.settings_theme)),
                SizedBox(height: 8.h),
                _SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: context.tr(LocaleKeys.settings_theme),
                  subtitle: settingsCubit.state.themeMode == ThemeMode.dark
                      ? context.tr(LocaleKeys.settings_dark)
                      : context.tr(LocaleKeys.settings_light),
                  trailing: Switch.adaptive(
                    value: settingsCubit.state.themeMode == ThemeMode.dark,
                    activeTrackColor: theme.colorScheme.primary,
                    onChanged: (_) => settingsCubit.toggleTheme(),
                  ),
                ),
                SizedBox(height: 20.h),
                _SectionLabel(label: context.tr(LocaleKeys.settings_about)),
                SizedBox(height: 8.h),
                _SettingsTile(
                  icon: Icons.info_outline,
                  title: context.tr(LocaleKeys.settings_about),
                  trailing: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      context.tr(LocaleKeys.settings_version),
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                    ),
                  ),
                ),
                _SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: context.tr(LocaleKeys.settings_privacy),
                ),
                SizedBox(height: 24.h),
                Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  child: ListTile(
                    leading: Container(
                      width: 40.w, height: 40.w,
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: const Icon(Icons.logout, color: Colors.red, size: 20),
                    ),
                    title: Text(context.tr(LocaleKeys.settings_logout),
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 14.sp)),
                    onTap: () => _showLogoutDialog(context),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(context.tr(LocaleKeys.settings_logout)),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(context.tr(LocaleKeys.common_cancel))),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: handle logout
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text(context.tr(LocaleKeys.settings_logout), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(label, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.grey[600])),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const _SettingsTile({required this.icon, required this.title, this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.only(bottom: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          width: 40.w, height: 40.w,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: theme.colorScheme.primary, size: 20.sp),
        ),
        title: Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
        subtitle: subtitle != null ? Text(subtitle!, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])) : null,
        trailing: trailing,
      ),
    );
  }
}

class _LangButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LangButton({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : theme.colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
        ),
      ),
    );
  }
}
