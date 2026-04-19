import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  void didUpdateWidget(covariant CustomBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() {
        _currentIndex = widget.currentIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CurvedNavigationBar(
      index: _currentIndex,
      height: 65,
      backgroundColor: Colors.transparent,
      color: theme.primaryColor,
      buttonBackgroundColor: theme.primaryColor,
      animationDuration: const Duration(milliseconds: 400),
      animationCurve: Curves.easeInOut,
      items: widget.items.map((e) {
        return Icon((e.icon as Icon).icon, size: 28, color: Colors.white);
      }).toList(),
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        widget.onTap(index);
      },
    );
  }
}
