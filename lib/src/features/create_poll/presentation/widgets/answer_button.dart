import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class AnswerButtonFon extends StatelessWidget {
  const AnswerButtonFon({super.key, required this.answer, required this.onTap});
  final String answer;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.c_93A2B4.withValues(alpha: 0.3)),
        child: Center(
          child: Text(
            answer,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.c_5856D6),
          ),
        ),
      ),
    );
  }
}
