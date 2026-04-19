import 'package:geniuses_school/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading_widget;
  final List<Widget>? extra_actions;
  final String? title;
  const AppBarWidget({
    super.key,
    this.leading_widget,
    this.extra_actions,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.primaryColor,
      foregroundColor: Colors.white,
      leadingWidth: MediaQuery.of(context).size.width * 0.2,
      leading: leading_widget,
      centerTitle: true,
      elevation: 0,
      title: title != null
          ? Text(
              title ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            )
          : null,
      actions: [
        if (extra_actions != null) ...extra_actions!,
        Image.asset(AppAssets.logo, height: 100),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
