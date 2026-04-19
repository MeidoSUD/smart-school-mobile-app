import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class TeacherCardShimmer extends StatelessWidget {
  const TeacherCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        interval: const Duration(milliseconds: 500),
        color: Colors.grey.shade300,
        colorOpacity: 0.3,
        enabled: true,
        direction: const ShimmerDirection.fromLTRB(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile image placeholder
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Text placeholders
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name placeholder
                        Container(
                          height: 16,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 8),

                        // Subject & service placeholder
                        Container(
                          height: 14,
                          width: MediaQuery.of(context).size.width * 0.5,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 8),

                        // Rating & availability placeholder
                        Container(
                          height: 14,
                          width: MediaQuery.of(context).size.width * 0.35,
                          color: Colors.grey.shade300,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 12),

                  // Price placeholder
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 50,
                        height: 16,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: 30,
                        height: 12,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Bio placeholder
              Container(
                height: 14,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 6),
              Container(
                height: 14,
                width: MediaQuery.of(context).size.width * 0.7,
                color: Colors.grey.shade300,
              ),

              const SizedBox(height: 16),

              // Button placeholder
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// ListView.builder(
//   itemCount: 3, // number of shimmer cards
//   padding: const EdgeInsets.symmetric(vertical: 16),
//   itemBuilder: (context, index) {
//     return const TeacherCardShimmer();
//   },
// )
