import 'package:flutter/material.dart';
import 'package:weather_test_task/presentation/theme/app_theme.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.bottom,
    required this.onTap,
    required this.iconData,
    this.left,
    this.right,
    this.show = true,
  });
  final double bottom;
  final bool show;
  final double? left;
  final double? right;
  final VoidCallback onTap;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      right: right,
      child: AnimatedOpacity(
        opacity: show ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: IgnorePointer(
          ignoring: !show,
          child: FloatingActionButton(
            backgroundColor: context.themeData.colorScheme.primary,
            onPressed: onTap,
            child: Icon(
              iconData,
              color: context.themeData.colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
