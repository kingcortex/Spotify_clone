import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Widget? widgetIcon;
  final VoidCallback? onTap;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;

  const CircleIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.size = 30,
    this.iconSize = 15,
    this.backgroundColor = const Color(0x1AFFFFFF), // white with opacity
    this.iconColor = Colors.white,
    this.widgetIcon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        alignment: Alignment.center,
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: widgetIcon ??
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
      ),
    );
  }
}
