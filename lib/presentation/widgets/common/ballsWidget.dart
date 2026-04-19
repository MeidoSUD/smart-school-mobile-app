import 'package:flutter/material.dart';

class BallsWidget extends StatelessWidget {
  final double size;
  final Color color;
  final Alignment alignment; // 🔹 control position (topRight, bottomLeft, etc.)
  final double opacity;

  const BallsWidget({
    super.key,
    this.size = 100,
    this.color = Colors.blue,
    this.alignment = Alignment.topRight,
    this.opacity = 0.2,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ClipOval(
        child: Container(
          width: size,
          height: size,
          color: color.withOpacity(opacity),
        ),
      ),
    );
  }
}
