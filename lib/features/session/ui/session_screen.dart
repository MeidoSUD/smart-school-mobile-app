import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../presentation/state/auth_provider.dart';
import '../controllers/session_provider.dart';
import 'widgets/session_filter_header.dart';
import 'widgets/session_shimmer_loading.dart';
import 'widgets/student_session_card.dart';
import 'widgets/teacher_session_card.dart';

class SessionScreen extends ConsumerWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final sessionState = ref.watch(sessionProvider);
    final authState = ref.watch(authProvider);
    final roleId = authState.user?.role_id ?? 4;
    final isTeacher = roleId == 3;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: RefreshIndicator(
        onRefresh: () async {
          // Trigger a reload of the sessions
          // We use 'refresh' or just call loadSessions again if the notifier supports it.
          // Assuming loadSessions clears/reloads or we can invalidate the provider.
          // Invalidating is often cleaner for Riverpod: ref.refresh(sessionProvider) if it's a FutureProvider, or notifier method.
          // Checking usage: ref.read(sessionProvider.notifier).loadSessions();
          await ref.read(sessionProvider.notifier).loadSessions();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: false, // Disappears on scroll down
              toolbarHeight: 0,
              elevation: 0,
              bottom: const SessionFilterHeader(),
            ),
            sessionState.sessions.when(
              data: (_) {
                final sessions = sessionState.filteredSessions;

                if (sessions.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_busy,
                            size: 64,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)!.noSessions,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(10),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final session = sessions[index];
                      // Display appropriate card based on role
                      if (isTeacher) {
                        return TeacherSessionCard(session: session);
                      } else {
                        return StudentSessionCard(session: session);
                      }
                    }, childCount: sessions.length),
                  ),
                );
              },
              loading: () =>
                  const SliverFillRemaining(child: SessionShimmerLoading()),
              error: (error, stack) => SliverFillRemaining(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          AppLocalizations.of(context)!.errorLoadingSessions,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          error.toString().replaceAll('Exception: ', ''),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ref.read(sessionProvider.notifier).loadSessions();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(AppLocalizations.of(context)!.retry),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
