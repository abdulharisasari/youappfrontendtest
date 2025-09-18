import 'package:flutter/material.dart';

import '../core/themes.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isPassword;
  final bool bg;
  final TextAlign textAlign;

  final ValueNotifier<bool> obscureNotifier;

  CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    this.isPassword = false,
    this.bg = true,
    this.textAlign = TextAlign.left,
  }) : obscureNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ValueListenableBuilder<bool>(
        valueListenable: obscureNotifier,
        builder: (context, obscure, _) {
          return TextField(
            controller: controller,
            focusNode: focusNode,
            obscureText: isPassword ? obscure : false,
            textAlign: textAlign,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              filled: bg,
              fillColor: bg ? Colors.white.withOpacity(0.06) : Colors.transparent,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontSize: 16,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () => obscureNotifier.value = !obscureNotifier.value,
                      icon: ShaderMask(
                        shaderCallback: (bounds) => goldGradient.createShader(
                          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                        ),
                        blendMode: BlendMode.srcIn,
                        child: Icon(
                          obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
