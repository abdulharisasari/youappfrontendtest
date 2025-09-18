import 'package:flutter/material.dart';
import '../core/themes.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final double fontSize;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 100,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:10,vertical: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(buttonDarkColor), Color(buttonLightColor), ],
              stops: [0.2488, 0.7849],
              transform: GradientRotation(108.32 * 3.1416 / 180)),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: Color(buttonLightColor).withOpacity(0.4),offset: Offset(0, 6),blurRadius: 20,)]),
          alignment: Alignment.center,
          child: Text(text,style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, ),
          ),
        )
      ),
    );
  }
}
