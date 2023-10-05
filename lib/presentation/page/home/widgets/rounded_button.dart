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
  });
  final double bottom;
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
      child: FloatingActionButton(
        backgroundColor: context.themeData.colorScheme.primary,
        onPressed: onTap,
        child: Icon(
          iconData,
          color: context.themeData.colorScheme.secondary,
        ),
      ),
    );
  }
}
