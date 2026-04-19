import 'package:country_flags/country_flags.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/teacher_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../l10n/app_localizations.dart';
import 'teacher_details_button.dart';

class TeacherCard extends StatelessWidget {
  final TeacherModel teacher;
  final VoidCallback? onTap;

  const TeacherCard({super.key, required this.teacher, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Logger.log(
      'teacher subjects ==> ${teacher.teacherSubjects.map((e) => e.toJson())}',
    );
    Logger.log('teacher availables times ==> ${teacher.availableTimes}');

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 335.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: onTap != null
            ? InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16.r),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 5.h),
                  child: _buildCardContent(context, theme),
                ),
              )
            : Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                child: _buildCardContent(context, theme),
              ),
      ),
    );
  }

  Widget _buildCardContent(BuildContext context, ThemeData theme) {
    final availableTimes = teacher.availableTimes as List? ?? [];
    final availableDaysCount = availableTimes.length;

    return Column(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: theme.primaryColor.withOpacity(0.2),
                  width: 2.w,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14.r),
                child: Image.network(
                  teacher.profileImage ??
                      "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 40.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(width: 16.w),

            // Teacher Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${teacher.firstName} ${teacher.lastName}",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 17.sp,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      if (teacher.verified == true)
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.verified_rounded,
                            size: 18.sp,
                            color: Colors.blue.shade600,
                          ),
                        ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Nationality
                  Row(
                    children: [
                      _buildNationalityFlag(teacher.nationality),
                      const SizedBox(width: 6),
                      Text(
                        teacher.nationality ??
                            AppLocalizations.of(context)!.notSpecified,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 4.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          _getServiceName(teacher.service),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getServiceCount(teacher.service),
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Rating and Available Days
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        size: 16,
                        color: Colors.amber.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        teacher.rating.toString(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "(${teacher.reviews.length})",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.schedule_rounded,
                        size: 16,
                        color: theme.primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        AppLocalizations.of(
                          context,
                        )!.availableDays(availableDaysCount),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        TeacherDetailsButton(
          context: context,
          teacher: teacher.toJson(),
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildNationalityFlag(String? nationality) {
    if (nationality == null) return const SizedBox();

    final countryCodeMap = {
      'saudi': 'SA',
      'sudanese': 'SD',
      'egyptian': 'EG',
      'jordanian': 'JO',
      'syrian': 'SY',
      'lebanese': 'LB',
      'palestinian': 'PS',
      'iraqi': 'IQ',
      'kuwaiti': 'KW',
      'emirati': 'AE',
      'qatari': 'QA',
      'bahraini': 'BH',
      'omani': 'OM',
      'yemeni': 'YE',
    };

    final code = countryCodeMap[nationality.toLowerCase()] ?? 'SA';

    return CountryFlag.fromCountryCode(
      code,
      width: 20.w,
      height: 14.h,
      borderRadius: 4.r,
    );
  }

  String _getServiceName(String service) {
    if (service.isEmpty) return '';

    try {
      final serviceId = int.tryParse(service);
      if (serviceId != null) {
        switch (serviceId) {
          case 6:
            return 'قدرات و تحصيل';
          case 4:
            return 'دورات تدريبية';
          case 3:
            return 'دروس خصوصية';
          case 2:
            return 'تعلم لغات';
          default:
            return service;
        }
      }
      return service;
    } catch (e) {
      return service;
    }
  }

  String _getServiceCount(String service) {
    if (service.isEmpty) return '';

    try {
      final serviceId = int.tryParse(service);
      if (serviceId != null) {
        final serviceObj = teacher.services.firstWhere(
          (s) => s.id == serviceId,
          orElse: () => TeacherService(id: 0),
        );

        if (serviceObj.keyName != null) {
          final key = serviceObj.keyName!.toLowerCase();

          if (key == 'private_lesson') {
            final subjectsCount = teacher.teacherSubjects.length;
            return subjectsCount > 0 ? '($subjectsCount مواد)' : '';
          } else if (key == 'language_learning') {
            final languagesCount = teacher.teacherLanguages.length;
            return languagesCount > 0 ? '($languagesCount لغات)' : '';
          } else if (key == 'courses') {
            final coursesCount = teacher.teacherCourses.length;
            return coursesCount > 0 ? '($coursesCount دورات)' : '';
          } else if (key == 'books') {
            return '';
          }
        }

        switch (serviceId) {
          case 6:
          case 3:
            final subjectsCount = teacher.teacherSubjects.length;
            return subjectsCount > 0 ? '($subjectsCount مواد)' : '';
          case 4:
            final languagesCount = teacher.teacherLanguages.length;
            return languagesCount > 0 ? '($languagesCount لغات)' : '';
          default:
            return '';
        }
      }
      return '';
    } catch (e) {
      return '';
    }
  }
}
