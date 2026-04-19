import 'package:geniuses_school/core/routes/app_routes.dart';
import 'package:geniuses_school/data/models/course_category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseCategoryWidget extends StatelessWidget {
  final CourseCategory category;
  final VoidCallback? onTap;

  const CourseCategoryWidget({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    try {
      if (category.id <= 0 ||
          category.nameAr.isEmpty ||
          category.nameAr.trim().isEmpty) {
        return const SizedBox.shrink();
      }

      final theme = Theme.of(context);

      final primaryColor = theme.primaryColor;
      final screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth <= 0) {
        return const SizedBox.shrink();
      }

      // Ensure a minimum reasonable width so text isn't crushed
      final cardWidth = 110.w;

      return Padding(
        padding: EdgeInsets.all(4.0.r),
        child: InkWell(
          onTap:
              onTap ??
              () {
                if (category.id > 0) {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.courses,
                    arguments: {'categoryId': category.id},
                  );
                }
              },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            width: cardWidth,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 8.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 4.w,
                ), // Reduced padding
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    (Localizations.localeOf(context).languageCode == 'ar'
                        ? category.nameAr
                        : category.nameEn),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp, // Slightly adjusted base size
                      height: 1.2,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 1.h),
                          blurRadius: 2.r,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      return const SizedBox.shrink();
    }
  }
}
