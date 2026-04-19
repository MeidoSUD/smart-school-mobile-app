import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class SessionShimmerLoading extends StatelessWidget {
  const SessionShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10), // Matched SessionScreen SliverPadding
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          // Match TeacherSessionCard Margin (horizontal 12)
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            color: Colors.grey[100]!,
            enabled: true,
            direction: const ShimmerDirection.fromLeftToRight(),
            child: Column(
              children: [
                // Header (Time & Calendar) - Matches Gradient Header in Cards
                Container(
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14, // Matched TeacherSessionCard Header Padding
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      // Icon Box
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Time Text
                      Container(
                        width: 100,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Spacer(),
                      // Date Box
                      Container(
                        width: 80,
                        height: 26,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Subject Line
                      Row(
                        children: [
                          // Subject Name
                          Expanded(
                            child: Container(
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Duration Badge
                          Container(
                            width: 70,
                            height: 26,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Status Badge
                          Container(
                            width: 50,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Teacher/Student Info Box
                      Container(
                        height: 58,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          children: [
                            // Avatar
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.grey[300],
                            ),
                            const SizedBox(width: 12),
                            // Name & Label
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 10,
                                    width: 40,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    height: 14,
                                    width: 100,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Action Button
                            Container(
                              width: 60,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(8),
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
        );
      },
    );
  }
}
