import '../../../../core/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../bloc/transport_cubit.dart';
import '../../../../core/di/injection.dart';
import '../bloc/transport_state.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (_) => getIt<TransportCubit>()..loadTransport(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          title: Text(context.tr(LocaleKeys.transport_title)),
        ),
        body: BlocBuilder<TransportCubit, TransportState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (transport) {
                return SingleChildScrollView(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [theme.colorScheme.primary, theme.colorScheme.primary.withValues(alpha: 0.8)],
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.directions_bus, color: Colors.white, size: 32.sp),
                            SizedBox(height: 12.h),
                            Text(context.tr(LocaleKeys.transport_route), style: TextStyle(color: Colors.white70, fontSize: 13.sp)),
                            SizedBox(height: 4.h),
                            Text(transport.route, style: TextStyle(color: Colors.white, fontSize: 22.sp, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _InfoRow(icon: Icons.person, label: context.tr(LocaleKeys.transport_driver_name), value: transport.driverName ?? 'N/A'),
                      _InfoRow(icon: Icons.phone, label: context.tr(LocaleKeys.transport_driver_phone), value: transport.driverPhone ?? 'N/A'),
                      _InfoRow(icon: Icons.directions_bus, label: context.tr(LocaleKeys.transport_bus_number), value: transport.busNumber ?? 'N/A'),
                      _InfoRow(icon: Icons.location_on, label: context.tr(LocaleKeys.transport_pickup_point), value: transport.pickupPoint ?? 'N/A'),
                      _InfoRow(icon: Icons.access_time, label: context.tr(LocaleKeys.transport_pickup_time), value: transport.pickupTime ?? 'N/A'),
                    ],
                  ),
                );
              },
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(message),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () => context.read<TransportCubit>().loadTransport(),
                      child: Text(context.tr(LocaleKeys.common_retry)),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
        title: Text(label, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
        subtitle: Text(value, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
