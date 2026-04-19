import 'package:flutter/material.dart';

import 'section_header.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final GlobalKey? titleKey;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onAction;
  final String? actionText;

  const HomeCard({
    super.key,
    required this.title,
    required this.icon,
    this.titleKey,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.onAction,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SectionHeader(
            title: title,
            icon: icon,
            titleKey: titleKey,
            onAction: onAction,
            actionText: actionText,
          ),
          if (padding != EdgeInsets.zero)
            Padding(padding: padding, child: child)
          else
            child,
        ],
      ),
    );
  }
}
