import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/notification_service.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:geniuses_school/presentation/state/notification_provider.dart';
import 'package:geniuses_school/presentation/widgets/OrderBottomSheet.dart';
import 'package:geniuses_school/presentation/widgets/common/appBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/home/teacher/ui/teacher_home_screen.dart';
import '../../../features/session/ui/session_screen.dart';
import '../../widgets/common/bottom_navbar.dart';
import '../profile/profile_screen.dart';
import 'home_sections.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;
  final GlobalKey<TeacherHomeScreenState> _teacherHomeKey =
      GlobalKey<TeacherHomeScreenState>();
  final GlobalKey<StudentHomeSectionState> _studentHomeKey =
      GlobalKey<StudentHomeSectionState>();
  final GlobalKey _helpKey = GlobalKey();
  final GlobalKey _notificationsKey = GlobalKey();

  Future<void> _startTeacherHomeTutorial(BuildContext context) async {
    await _teacherHomeKey.currentState?.startTutorialManual(context);
  }

  Future<void> _startStudentHomeTutorial(BuildContext context) async {
    await _studentHomeKey.currentState?.startTutorialManual(context);
  }

  List<Widget> _getScreens(role) {
    switch (role) {
      case 4:
        return [
          StudentHomeSection(
            key: _studentHomeKey,
            helpKey: _helpKey,
            notificationsKey: _notificationsKey,
          ),
          const SessionScreen(),
          const ProfileScreen(),
        ];
      case 3:
        return [
          TeacherHomeScreen(
            key: _teacherHomeKey,
            helpKey: _helpKey,
            notificationsKey: _notificationsKey,
          ),
          const SessionScreen(),
          const ProfileScreen(),
        ];
      default:
        return [VisitorHomeSection(), const ProfileScreen()];
    }
  }

  List<String> _getTitle(role, BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    switch (role) {
      case 4:
        return [
          localizations.appTitle,
          localizations.mySessions,
          localizations.myProfile,
        ];
      case 3:
        return [
          localizations.appTitle,
          localizations.mySessions,
          localizations.myProfile,
        ];
      default:
        return [localizations.appTitle, localizations.myProfile];
    }
  }

  List<BottomNavigationBarItem> _getNavItems(role, BuildContext context) {
    switch (role) {
      case 4:
        return [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Lessons",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ];
      case 3:
        return [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Lessons",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ];
      default:
        return [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ];
    }
  }

  @override
  void initState() {
    super.initState();
    final authState = ref.read(authProvider);
    final user = authState.user;
    if (user != null) {
      NotificationService.initialize(
        userId: user.id,
        userToken: user.token,
        ref: ref,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final int roleId = user?.role_id ?? 0;

    if (authState.status == AuthStatus.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final screens = _getScreens(roleId);
    final navItems = _getNavItems(roleId, context);
    final titles = _getTitle(roleId, context);

    if (_currentIndex >= screens.length) {
      _currentIndex = 0;
    }

    final theme = Theme.of(context);

    final content = Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: titles[_currentIndex],
        leading_widget: Container(
          alignment: const Alignment(0, 0),
          child: Consumer(
            builder: (context, ref, _) {
              final unreadCount = ref.watch(notificationProvider).unreadCount;
              return Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: [
                  if (roleId == 3 && _currentIndex == 0)
                    IconButton(
                      key: _helpKey,
                      icon: const Icon(Icons.help_outline, color: Colors.white),
                      onPressed: () => _startTeacherHomeTutorial(context),
                    ),
                  if (roleId == 4 && _currentIndex == 0)
                    IconButton(
                      key: _helpKey,
                      icon: const Icon(Icons.help_outline, color: Colors.white),
                      onPressed: () => _startStudentHomeTutorial(context),
                    ),
                  InkWell(
                    onTap: () {
                      if (user == null) {
                        Navigator.pushNamed(context, '/login');
                        return;
                      }
                      Navigator.pushNamed(context, '/notifications');
                    },
                    child: Stack(
                      key: _notificationsKey,
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 28,
                        ),
                        if (unreadCount > 0)
                          Positioned(
                            top: -4,
                            right: -4,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 8,
                              child: Text(
                                unreadCount > 9 ? '9+' : unreadCount.toString(),
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        key: ValueKey(roleId),
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: navItems,
      ),
      floatingActionButton: roleId == 4
          ? FloatingActionButton.extended(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              onPressed: () => showOrderBottomSheet(context),
              label: Text(AppLocalizations.of(context)!.addOrder),
            )
          : null,
    );

    return content;
  }
}
