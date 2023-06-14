import 'package:flutter/material.dart';

class CustomCircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final Widget child;

  const CustomCircleButton({
    required this.color,
    required this.onTap,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 0,
      height: 40,
      color: color,
      onPressed: onTap,
      shape: const CircleBorder(),
      child: child,
    );
  }
}