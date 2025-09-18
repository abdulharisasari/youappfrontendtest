import 'package:flutter/material.dart';
import 'package:youappgetxtest/core/themes.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;

  const CustomBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment.topRight,
          radius: 3.4,
          colors: [
            Color(primaryLightColor),
            Color(primaryColor),
            Color(primaryDarkColor),
          ],
        ),
      ),
      child: child,
    );
  }
}
