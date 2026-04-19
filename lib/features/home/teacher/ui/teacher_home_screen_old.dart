import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../presentation/state/auth_provider.dart';
import 'widgets/dashboard_card.dart';
import 'widgets/management_card.dart';
import 'widgets/orders_section.dart'; // Import OrdersSection

class TeacherHomeScreen extends ConsumerWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch AuthProvider to get current user data
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final profile = user?.profile;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        user?.is_active == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: user?.is_active == true
                            ? Colors.green
                            : Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        user?.is_active == true ? "Active" : "Inactive",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: user?.is_active == true
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: user?.is_active ?? false,
                    onChanged: (val) {
                      ref.read(authProvider.notifier).toggleActiveStatus();
                    },
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 16).copyWith(top: 5),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  DashboardCard(
                    earnings: profile?.totalEarnings ?? 0.0,
                    rating: profile?.rating ?? 0.0,
                    serviceId: profile?.serviceId,
                    subjectsCount: profile?.subjects_count,
                    languagesCount: profile?.languages_count,
                    coursesCount: profile?.courses_count,
                  ),
                  ManagementCard(serviceId: profile?.serviceId),

                  const SizedBox(height: 16),

                  // Orders Section
                  const OrdersSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
