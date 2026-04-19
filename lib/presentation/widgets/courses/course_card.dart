import 'package:geniuses_school/data/models/course_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCardWidget extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final double? width;

  const CourseCardWidget({
    super.key,
    required this.course,
    required this.onTap,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Use constraints from LayoutBuilder to prevent overflow
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight),
            child: Container(
              width: width,
              height: constraints.maxHeight, // Force full height usage
              margin: const EdgeInsets.only(bottom: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10.r,
                    offset: Offset(0, 2.h),
                  ),
                ],
              ),
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max, // Fill the container
                  children: [
                    // Course Image - Responsive aspect ratio
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.r),
                          ),
                          child: AspectRatio(
                            aspectRatio: 2.5,
                            child: Image.network(
                              course.image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 40.sp,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        // Category Badge
                        Positioned(
                          top: 10.h,
                          right: 10.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade600,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              course.category,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        // Rating Badge
                        Positioned(
                          top: 10.h,
                          left: 10.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  course.rating.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Course Content - Expanded to fill remaining space
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Title
                              Text(
                                course.title,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1E293B),
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(height: 4.h),

                              // Description - Flexible to prevent overflow
                              Text(
                                course.description,
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.grey.shade600,
                                  height: 1.3,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),

                              SizedBox(height: 6.h),

                              // Teacher & Level
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 9.r,
                                    backgroundColor: Colors.grey.shade100,
                                    child: Icon(
                                      Icons.person,
                                      size: 11.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Expanded(
                                    child: Text(
                                      course.teacherName,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey.shade700,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getLevelColor(
                                        course.level,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Text(
                                      course.level,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: _getLevelColor(course.level),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 6.h),

                              // Info Chips
                              Wrap(
                                spacing: 8.w,
                                runSpacing: 4.h,
                                children: [
                                  _buildMiniInfo(
                                    context,
                                    Icons.access_time_rounded,
                                    AppLocalizations.of(
                                      context,
                                    )!.hoursShort(course.hours),
                                  ),
                                  _buildMiniInfo(
                                    context,
                                    Icons.group_rounded,
                                    AppLocalizations.of(
                                      context,
                                    )!.availableSeatsCount(
                                      course.availableSeats,
                                    ),
                                    color: course.availableSeats <= 5
                                        ? Colors.orange
                                        : null,
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Footer (Price & CTA) - Stays at bottom
                          Container(
                            padding: EdgeInsets.only(top: 6.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                if (Theme.of(context).platform !=
                                    TargetPlatform.iOS)
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.price,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        Text(
                                          "${course.price.toInt()} ${AppLocalizations.of(context)!.currency}",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(
                                              context,
                                            ).primaryColor,
                                            height: 1.1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                else
                                  const Spacer(),
                                InkWell(
                                  onTap: onTap,
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 14.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context)!.details,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMiniInfo(
    BuildContext context,
    IconData icon,
    String text, {
    Color? color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: color ?? Colors.grey.shade500),
        SizedBox(width: 4.w),
        Text(
          text,
          style: TextStyle(
            fontSize: 11.sp,
            color: color ?? Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Color _getLevelColor(String level) {
    // Note: level string usually comes from backend in Arabic. We should probably ideally check against ID or enum.
    // Assuming backend returns these specific Arabic strings for now.
    if (level.contains('مبتدئ') || level.contains('Beginner')) {
      return Colors.green;
    }
    if (level.contains('متوسط') || level.contains('Intermediate')) {
      return Colors.orange;
    }
    if (level.contains('متقدم') || level.contains('Advanced')) {
      return Colors.red;
    }
    return Colors.grey;
  }
}
