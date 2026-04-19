import 'package:geniuses_school/core/constants/app_assets.dart';
import 'package:geniuses_school/core/routes/app_routes.dart';
import 'package:geniuses_school/core/services/tutorial_service.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/course_category_model.dart';
import 'package:geniuses_school/data/repositories/course_repository.dart';
import 'package:geniuses_school/presentation/state/filters_provider.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/screens/common/web_view_screen.dart';
import 'package:geniuses_school/presentation/state/auth_provider.dart';
import 'package:geniuses_school/presentation/state/courses_provider.dart';
import 'package:geniuses_school/presentation/state/lessons_provider.dart';
import 'package:geniuses_school/presentation/state/subjects_provider.dart';
import 'package:geniuses_school/presentation/state/teachers_provider.dart';
import 'package:geniuses_school/presentation/widgets/common/ballsWidget.dart';
import 'package:geniuses_school/presentation/widgets/common/course_category_shimmer_widget.dart';
import 'package:geniuses_school/presentation/widgets/common/subject_shimmer_widget.dart';
import 'package:geniuses_school/presentation/widgets/common/teacher_card_shimmer.dart';
import 'package:geniuses_school/presentation/widgets/courses/course_card.dart';
import 'package:geniuses_school/presentation/widgets/courses/course_details_sheet.dart';
import 'package:geniuses_school/presentation/widgets/home/course_category_widget.dart';
import 'package:geniuses_school/presentation/widgets/home/service_card.dart';
import 'package:geniuses_school/presentation/widgets/home/service_shimmer_widget.dart';
import 'package:geniuses_school/presentation/widgets/home/subjectWidget.dart';
import 'package:geniuses_school/presentation/widgets/lessons/lesson_card_widget.dart';
import 'package:geniuses_school/presentation/widgets/profile/complete_profile_dialog.dart';
import 'package:geniuses_school/presentation/widgets/teacher/teacherDashboardCardWidget.dart';
import 'package:geniuses_school/presentation/widgets/teacher/teacher_card.dart';
import 'package:geniuses_school/presentation/widgets/teacher/teacher_services_management_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/common/ads_banner_widget.dart';
import '../../widgets/common/search_bar_widget.dart';
import '../../widgets/common/section_title.dart';

class VisitorHomeSection extends ConsumerStatefulWidget {
  const VisitorHomeSection({super.key});

  @override
  ConsumerState<VisitorHomeSection> createState() => _VisitorHomeSectionState();
}

class _VisitorHomeSectionState extends ConsumerState<VisitorHomeSection> {
  final ScrollController _teacherScrollController = ScrollController();
  int _teacherActiveIndex = 0;

  @override
  void dispose() {
    _teacherScrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_teacherScrollController.hasClients) return;
    // itemWidth = card width (335.w) + horizontal padding (16.w)
    final double itemWidth = 351.w;
    final int newIndex = (_teacherScrollController.offset / itemWidth).round();
    if (newIndex != _teacherActiveIndex) {
      setState(() {
        _teacherActiveIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return _BaseHomeSection(
      children: [
        // ------------- search -------------------
        const SearchBarWidget(),
        // ------------- Banner -------------------
        const AdsBannerWidget(),

        // ------------- Top Teacher -------------------
        SectionTitle(
          title: AppLocalizations.of(context)!.topTeachers,
          onViewAll: () {
            CompleteProfileDialog.show(
              context,
              onComplete: () {
                Navigator.pushNamed(context, '/roles');
              },
            );
          },
        ),
        Column(
          children: [
            SizedBox(
              height: 220.h,
              child: Consumer(
                builder: (context, ref, _) {
                  final teachersState = ref.watch(teachersProvider);

                  return teachersState.when(
                    data: (teachers) {
                      if (teachers.isEmpty) return const SizedBox.shrink();
                      return NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          _onScroll();
                          return true;
                        },
                        child: ListView.builder(
                          controller: _teacherScrollController,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: teachers.length,
                          itemBuilder: (context, index) {
                            final t = teachers[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: TeacherCard(
                                teacher: t,
                                onTap: () {
                                  CompleteProfileDialog.show(
                                    context,
                                    onComplete: () {
                                      Navigator.pushNamed(context, '/roles');
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                    loading: () => SizedBox(
                      height: 220.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemBuilder: (context, index) {
                          return const TeacherCardShimmer();
                        },
                      ),
                    ),
                    error: (err, stack) => Text(
                      '${AppLocalizations.of(context)!.errorPrefix}$err',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Consumer(
              builder: (context, ref, _) {
                final teachersState = ref.watch(teachersProvider);
                return teachersState.maybeWhen(
                  data: (teachers) {
                    if (teachers.length <= 1) return const SizedBox.shrink();
                    return AnimatedSmoothIndicator(
                      activeIndex: _teacherActiveIndex,
                      count: teachers.length,
                      effect: ScrollingDotsEffect(
                        activeDotColor: Theme.of(context).primaryColor,
                        dotColor: Colors.grey.withOpacity(0.3),
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotScale: 1.3,
                        spacing: 8,
                      ),
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),

        // ------------- Our Services -------------------
        SectionTitle(title: AppLocalizations.of(context)!.ourServices),

        const _ServicesList(),

        //----------------- courses -------------------
        SectionTitle(
          title: AppLocalizations.of(context)!.trainingCourses,
          onViewAll: () {
            if (user?.role_id != 3 && user?.role_id != 4) {
              CompleteProfileDialog.show(
                context,
                onComplete: () {
                  Navigator.pushNamed(context, '/login');
                },
              );
            } else {
              Navigator.pushNamed(context, '/courses');
            }
          },
        ),

        SizedBox(
          height: 0.55.sh,
          child: Consumer(
            builder: (context, ref, _) {
              final coursesState = ref.watch(coursesProvider);
              return coursesState.when(
                data: (courses) {
                  final limitedCourses = courses.take(10).toList();
                  if (limitedCourses.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noCoursesAvailable,
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: limitedCourses.length,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    itemBuilder: (context, index) {
                      final course = limitedCourses[index];
                      return Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: CourseCardWidget(
                          width: 1.sw > 600 ? 300.w : 0.85.sw,
                          course: course,
                          onTap: () {
                            if (user?.role_id != 3 && user?.role_id != 4) {
                              CompleteProfileDialog.show(
                                context,
                                onComplete: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                              );
                              return;
                            }
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (context) =>
                                  CourseDetailsSheet(course: course),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, __) => Center(child: Text(err.toString())),
              );
            },
          ),
        ),

        // -------------- Subjects -----------------------
        SectionTitle(title: AppLocalizations.of(context)!.subjects),
        SizedBox(
          height: 0.1.sh,
          child: Consumer(
            builder: (context, ref, _) {
              final subjectState = ref.watch(publicSubjectsProvider);

              return subjectState.when(
                data: (data) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    itemBuilder: (context, index) {
                      final s = data[index];
                      return SubjectWidget(
                        subject: s.name,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/lessons',
                            arguments: {'subject': s},
                          );
                        },
                      );
                    },
                  );
                },
                loading: () => SizedBox(
                  height: 0.1.sh,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5, // number of shimmer items
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                    itemBuilder: (context, index) {
                      return SubjectShimmerWidget(width: 120.w, height: 60.h);
                    },
                  ),
                ),
                error: (_, __) =>
                    Text(AppLocalizations.of(context)!.errorLoadingData),
              );
            },
          ),
        ),
        SizedBox(height: 40),

        //   SectionTitle(
        //   title: "طلبات التدريس",
        //   onViewAll: () {
        //     // TODO: Navigate to full requests screen
        //        if (user!.roleId != 2 && user!.roleId != 1) {
        //     CompleteProfileDialog.show(
        //       context,
        //       onComplete: () {
        //         Navigator.pushNamed(context, '/roles');
        //       },
        //     );
        //   } else {
        //     Navigator.pushNamed(context, '/orders');
        //   }

        //   },
        // ),

        //  SizedBox(
        //   width: MediaQuery.of(context).size.width * 0.9,
        //   height: 300,
        //   child: ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     itemCount: 3,
        //     itemBuilder: (context, index) {
        //       final req = dummyRequests[index];
        //       return TeachRequestCard(
        //         subject: req["subject"]!,
        //         studentName: req["student"]!,
        //         date: req["date"]!,
        //         description: req["desc"]!, // Changed from 'desc' to 'description'
        //         price: req["price"]!,
        //         status: _parseStatus(req["status"]!), // Convert string to enum
        //         onTap: () {
        //           // Handle card tap - navigate to details page
        //           print('Tapped on ${req["subject"]} request');
        //         },
        //         onAccept: req["status"]!.toLowerCase() == "pending" ? () {
        //           // Handle accept action
        //           print('Accepted ${req["subject"]} request');
        //         } : null,
        //         onDecline: req["status"]!.toLowerCase() == "pending" ? () {
        //           // Handle decline action
        //           print('Declined ${req["subject"]} request');
        //         } : null,
        //       );
        //     },
        //   ),
        // )
      ],
    );
  }
}

class StudentHomeSection extends ConsumerStatefulWidget {
  final GlobalKey helpKey;
  final GlobalKey notificationsKey;
  const StudentHomeSection({
    super.key,
    required this.helpKey,
    required this.notificationsKey,
  });

  @override
  ConsumerState<StudentHomeSection> createState() => StudentHomeSectionState();
}

class StudentHomeSectionState extends ConsumerState<StudentHomeSection> {
  final ScrollController _teacherScrollController = ScrollController();
  int _teacherActiveIndex = 0;
  final GlobalKey _teachersKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _coursesKey = GlobalKey();
  final GlobalKey _categoriesKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTutorial();
    });
  }

  Future<void> _checkAndShowTutorial() async {
    final authState = ref.read(authProvider);
    if (authState.user?.role_id != 4) return;

    if (await TutorialService.hasShownTutorial(
      TutorialService.studentHomeTutorialId,
    )) {
      return;
    }
    if (!mounted) return;
    await _startTutorial(markAsShown: true);
  }

  Future<void> startTutorialManual(BuildContext context) async {
    await _startTutorial(markAsShown: false);
  }

  Future<void> _startTutorial({required bool markAsShown}) async {
    final loc = AppLocalizations.of(context)!;
    await TutorialService.startGuidedTour(
      context: context,
      tutorialId: TutorialService.studentHomeTutorialId,
      markAsShown: markAsShown,
      tourSteps: [
        {
          'key': widget.helpKey,
          'title': loc.appTitle,
          'description': loc.onboardingDesc1, // Reuse some existing if needed, or new ones
        },
        {
          'key': widget.notificationsKey,
          'title': loc.tutorial_student_home_title_notifications,
          'description': loc.tutorial_student_home_desc_notifications,
        },
        {
          'key': _teachersKey,
          'title': loc.tutorial_student_home_title_teachers,
          'description': loc.tutorial_student_home_desc_teachers,
        },
        {
          'key': _servicesKey,
          'title': loc.tutorial_student_home_title_services,
          'description': loc.tutorial_student_home_desc_services,
        },
        {
          'key': _coursesKey,
          'title': loc.tutorial_student_home_title_courses,
          'description': loc.tutorial_student_home_desc_courses,
        },
        {
          'key': _categoriesKey,
          'title': loc.tutorial_student_home_title_categories, // Use loc keys I added
          'description': loc.tutorial_student_home_desc_categories,
        },
      ],
    );
  }

  @override
  void dispose() {
    _teacherScrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_teacherScrollController.hasClients) return;
    final double itemWidth = 351.w;
    final int newIndex = (_teacherScrollController.offset / itemWidth).round();
    if (newIndex != _teacherActiveIndex) {
      setState(() {
        _teacherActiveIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;
    return _BaseHomeSection(
      children: [
        // const SearchBarWidget(),
        // ------------- Banner -------------------
        const AdsBannerWidget(),
        // ------------- Top Teacher -------------------
        SectionTitle(
          key: _teachersKey,
          title: AppLocalizations.of(context)!.topTeachers,
          onViewAll: () {
            Navigator.pushNamed(context, "/lessons");
          },
        ),
        Column(
          children: [
            SizedBox(
              height: 220.h,
              child: Consumer(
                builder: (context, ref, _) {
                  final teachersState = ref.watch(teachersProvider);

                  return teachersState.when(
                    data: (teachers) {
                      if (teachers.isEmpty) return const SizedBox.shrink();
                      return NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          _onScroll();
                          return true;
                        },
                        child: ListView.builder(
                          controller: _teacherScrollController,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: teachers.length,
                          itemBuilder: (context, index) {
                            final t = teachers[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: TeacherCard(teacher: t),
                            );
                          },
                        ),
                      );
                    },
                    loading: () => SizedBox(
                      height: 220.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemBuilder: (context, index) {
                          return const TeacherCardShimmer();
                        },
                      ),
                    ),
                    error: (err, stack) => Text(
                      '${AppLocalizations.of(context)!.errorPrefix}$err',
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Consumer(
              builder: (context, ref, _) {
                final teachersState = ref.watch(teachersProvider);
                return teachersState.maybeWhen(
                  data: (teachers) {
                    if (teachers.length <= 1) return const SizedBox.shrink();
                    return AnimatedSmoothIndicator(
                      activeIndex: _teacherActiveIndex,
                      count: teachers.length,
                      effect: ScrollingDotsEffect(
                        activeDotColor: Theme.of(context).primaryColor,
                        dotColor: Colors.grey.withOpacity(0.3),
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotScale: 1.3,
                        spacing: 8,
                      ),
                    );
                  },
                  orElse: () => const SizedBox.shrink(),
                );
              },
            ),
          ],
        ),

        // ------------- Our Services -------------------
        SectionTitle(
          key: _servicesKey,
          title: AppLocalizations.of(context)!.ourServices,
        ),

        _ServicesList(
          userServiceId: user?.profile?.services?.firstOrNull?.serviceId,
        ),

        //----------------- courses -------------------
        SectionTitle(
          key: _coursesKey,
          title: AppLocalizations.of(context)!.trainingCourses,
          onViewAll: () {
            Navigator.pushNamed(context, '/courses');
          },
        ),

        SizedBox(
          height: 350.h,
          child: Consumer(
            builder: (context, ref, _) {
              final coursesState = ref.watch(coursesProvider);
              return coursesState.when(
                data: (courses) {
                  final limitedCourses = courses.take(10).toList();
                  if (limitedCourses.isEmpty) {
                    return Center(
                      child: Text(
                        AppLocalizations.of(context)!.noCoursesAvailable,
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: limitedCourses.length,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    itemBuilder: (context, index) {
                      final course = limitedCourses[index];
                      return Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: CourseCardWidget(
                          width: 1.sw > 600 ? 300.w : 0.85.sw,
                          course: course,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (context) =>
                                  CourseDetailsSheet(course: course),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, __) => Center(child: Text(err.toString())),
              );
            },
          ),
        ),

        // -------------- Course Categories -----------------------
        SectionTitle(
          key: _categoriesKey,
          title: AppLocalizations.of(context)!.courseCategories,
          onViewAll: () {
            Navigator.pushNamed(context, AppRoutes.courseCategories);
          },
        ),

        SizedBox(height: 0.1.sh, child: _CourseCategoriesList()),
        SizedBox(height: 70),
      ],
    );
  }
}

class _CourseCategoriesList extends StatefulWidget {
  const _CourseCategoriesList();

  @override
  State<_CourseCategoriesList> createState() => _CourseCategoriesListState();
}

class _CourseCategoriesListState extends State<_CourseCategoriesList> {
  Future<List<CourseCategory>>? _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    try {
      _categoriesFuture = CourseRepository().getCourseCategories();
      await _categoriesFuture;
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      Logger.log("Error initializing categories: $e");
      if (mounted) {
        setState(() {
          _categoriesFuture = Future.value(<CourseCategory>[]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_categoriesFuture == null) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        itemBuilder: (context, index) {
          return CourseCategoryShimmerWidget(width: 120.w, height: 60.h);
        },
      );
    }

    return FutureBuilder<List<CourseCategory>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            itemBuilder: (context, index) {
              return CourseCategoryShimmerWidget(width: 120.w, height: 60.h);
            },
          );
        }

        if (snapshot.hasError) {
          Logger.log("Error loading categories: ${snapshot.error}");
          return Center(
            child: Text(AppLocalizations.of(context)!.errorLoadingCategories),
          );
        }

        final categories = snapshot.data;
        if (categories == null || categories.isEmpty) {
          return Center(
            child: Text(AppLocalizations.of(context)!.noCategoriesAvailable),
          );
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          itemBuilder: (context, index) {
            if (index >= categories.length) {
              return const SizedBox.shrink();
            }
            final category = categories[index];
            if (category.id <= 0 ||
                category.nameAr.isEmpty ||
                category.nameAr.trim().isEmpty) {
              return const SizedBox.shrink();
            }
            try {
              return CourseCategoryWidget(category: category);
            } catch (e) {
              Logger.log("Error building category widget: $e");
              return const SizedBox.shrink();
            }
          },
        );
      },
    );
  }
}

class TeacherHomeSection extends StatelessWidget {
  const TeacherHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _BaseHomeSection(
      children: [
        const SearchBarWidget(),
        const AdsBannerWidget(),

        // ------------ Earning ----------------------
        SectionTitle(title: AppLocalizations.of(context)!.earnings),
        Consumer(
          builder: (context, ref, _) {
            final authState = ref.watch(authProvider);
            final user = authState.user;
            return TeacherDashboardCardWidget(
              todayEarnings: user!.profile!.todayEarnings ?? 0.0,
              monthEarnings: user.profile!.monthEarnings ?? 0.0,
              totalEarnings: user.profile!.totalEarnings ?? 0.0,
              totalLessons: user.profile!.total_lessons ?? 0,
              ongoingLessons: user.profile!.current_lessons ?? 0,
              currentBalance: user.profile!.current_balance ?? 0.0,
              currency: AppLocalizations.of(context)!.currency,
            );
          },
        ),

        // -------------- Lessons -----------------------
        SectionTitle(
          title: AppLocalizations.of(context)!.lessons,
          onViewAll: () {
            Navigator.pushNamed(context, '/my-lessons');
          },
        ),

        SizedBox(
          height: 0.27.sh,
          child: Consumer(
            builder: (context, ref, _) {
              final lessonsState = ref.watch(lessonsProvider);
              // debugPrint("lessons state: ${lessonsState.value!.map((e) => e.toJson())}");
              return lessonsState.when(
                data: (response) {
                  final lessons = response.data?.data ?? [];
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 8.0.w, bottom: 5.h),
                        child: LessonCardWidget(
                          session: lessons[index],
                          width: 1.sw > 600 ? 300.w : 0.8.sw,
                        ),
                      );
                    },
                  );
                },
                error: (err, stack) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(
                            context,
                          )!.genericError(err.toString()),
                        ),
                      ),
                    );
                  });
                  return const SizedBox(); // Return an empty widget
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            },
          ),
        ),
        SizedBox(height: 20.h),

        // -------------- Services Management -----------------------
        Consumer(
          builder: (context, ref, _) {
            final user = ref.watch(authProvider).user;
            if (user?.profile?.teacher_service?['service_id'] == 3 ||
                user?.profile?.teacher_service?['service_id'] == 2) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: const TeacherServicesManagementWidget(),
              );
            }
            return const SizedBox.shrink();
          },
        ),

        // ------------- Teach Requests -------------------

        //   SectionTitle(
        //   title: "طلبات التدريس",
        //   onViewAll: () {
        //     // TODO: Navigate to full requests screen
        //   },
        // ),

        //     SizedBox(
        //   width: MediaQuery.of(context).size.width * 0.9,
        //   height: 300,
        //   child: ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     itemCount: 3,
        //     itemBuilder: (context, index) {
        //       final req = dummyRequests[index];
        //       return TeachRequestCard(
        //         subject: req["subject"]!,
        //         studentName: req["student"]!,
        //         date: req["date"]!,
        //         description: req["desc"]!, // Changed from 'desc' to 'description'
        //         price: req["price"]!,
        //         status: _parseStatus(req["status"]!), // Convert string to enum
        //         onTap: () {
        //           // Handle card tap - navigate to details page
        //           print('Tapped on ${req["subject"]} request');
        //         },
        //         onAccept: req["status"]!.toLowerCase() == "pending" ? () {
        //           // Handle accept action
        //           print('Accepted ${req["subject"]} request');
        //         } : null,
        //         onDecline: req["status"]!.toLowerCase() == "pending" ? () {
        //           // Handle decline action
        //           print('Declined ${req["subject"]} request');
        //         } : null,
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}

class _BaseHomeSection extends StatelessWidget {
  final List<Widget> children;
  const _BaseHomeSection({required this.children});

  @override
  Widget build(BuildContext context) {
    final isTablet = 1.sw >= 600;

    return SafeArea(
      child: Stack(
        children: [
          // background balls
          BallsWidget(
            size: 100,
            alignment: const Alignment(1.5, 0.2),
            opacity: 0.1,
            color: Theme.of(context).primaryColor,
          ),
          BallsWidget(
            size: 100,
            alignment: const Alignment(-1.2, 0.9),
            opacity: 0.1,
            color: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 20.h),
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: isTablet ? 800 : double.infinity,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: children,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesList extends ConsumerWidget {
  final int? userServiceId;
  const _ServicesList({this.userServiceId});

  /// Fallback local asset icon when the API image field is null / empty.
  String _getFallbackIcon(int id) {
    switch (id) {
      case 1:
        return AppAssets.lessons; // دروس خصوصية
      case 2:
        return AppAssets.math; // قدرات
      case 3:
        return AppAssets.lang; // لغات
      case 4:
        return AppAssets.course; // دورات
      case 5:
        return AppAssets.books; // كتب
      default:
        return AppAssets.lessons;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(servicesProvider);

    return servicesAsync.when(
      loading: () => GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4, // show 4 shimmer placeholders
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1.sw > 600 ? 3 : 2,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 1.0,
        ),
        itemBuilder: (context, index) => const ServiceShimmerWidget(),
      ),
      error: (err, _) => Center(
        child: Text(AppLocalizations.of(context)!.errorLoadingData),
      ),
      data: (services) {
        if (services.isEmpty) return const SizedBox();

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1.sw > 600 ? 3 : 2,
            mainAxisSpacing: 12.h,
            crossAxisSpacing: 12.w,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final service = services[index];
            final id = service['id'] as int;
            final keyName = service['key_name'] as String? ?? '';
            final imageUrl = service['image'] as String?;
            final isAr =
                Localizations.localeOf(context).languageCode == 'ar';
            final name = isAr
                ? (service['name_ar'] ?? service['name'] ?? service['title'])
                : (service['name_en'] ?? service['name'] ?? service['title']);
            final description = isAr
                ? (service['description_ar'] ?? '')
                : (service['description_en'] ?? '');

            return ServiceCard(
              title: name,
              description: description,
              iconUrl: imageUrl,
              iconAsset: _getFallbackIcon(id),
              onTap: () {
                final authState = ref.read(authProvider);
                final user = authState.user;
                final bool isVisitor =
                    user?.role_id != 3 && user?.role_id != 4;

                if (isVisitor) {
                  CompleteProfileDialog.show(
                    context,
                    onComplete: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  );
                  return;
                }

                // Navigation based on key_name
                if (keyName == 'study-books') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewScreen()),
                  );
                } else if (keyName == 'training-courses') {
                  Navigator.pushNamed(context, '/courses');
                } else {
                  // All other services → teachers list filtered by service id
                  Navigator.pushNamed(
                    context,
                    '/lessons',
                    arguments: {'service': id},
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}

