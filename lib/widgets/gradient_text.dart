import 'package:flutter/material.dart';
import '../core/themes.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;
  final bool underLine;

  const GradientText(
    this.text, {
    super.key,
    required this.style,
    this.gradient = goldGradient,
    this.underLine = true
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color:underLine == true? Color(goldColor): Colors.transparent))
      ),
      child: ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) =>gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
        child: Text(text, style: style,),
      ),
    );
  }
}
