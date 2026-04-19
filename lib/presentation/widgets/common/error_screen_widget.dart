import 'package:geniuses_school/core/utils/error_handler.dart';
import 'package:geniuses_school/core/utils/error_mapper.dart';
import 'package:geniuses_school/presentation/widgets/common/appBarWidget.dart';
import 'package:geniuses_school/presentation/widgets/common/ballsWidget.dart';
import 'package:flutter/material.dart';

class ErrorScreenWidget extends StatelessWidget {
  final String message;
  const ErrorScreenWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Stack(
        children: [
          BallsWidget(
            size: 40,
            color: Colors.red,
            alignment: Alignment(1.1, -0.8),
            opacity: 0.4,
          ),

          BallsWidget(
            size: 100,
            color: Colors.red,
            alignment: Alignment(-1.3, 0.5),
            opacity: 0.7,
          ),
          BallsWidget(
            size: 120,
            color: Colors.red,
            alignment: Alignment(-1.3, -0.9),
            opacity: 0.2,
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon with a circular background
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.error, size: 80, color: Colors.red),
                  ),
                  const SizedBox(height: 24),
                  // Error message text
                  Text(
                    ErrorMapper.translate(
                      context,
                      ErrorHandler.getMessageBasedOnContent(message),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Retry button
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
