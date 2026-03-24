import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/core/icons/app_icons.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
class GenderSelect extends StatefulWidget {
  const GenderSelect({super.key, required this.onTap, required this.isSelected});
  final VoidCallback onTap;
  final bool isSelected;

  @override
  State<GenderSelect> createState() => _GenderSelectState();
}

class _GenderSelectState extends State<GenderSelect> {
  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: widget.onTap,
      child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.c_A0A4A7.withValues(alpha: 0.5),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
            color: AppColors.white,
          ),
          child: Center(
            child:
                widget.isSelected ? SvgPicture.asset(AppImages.answerSelected) : const SizedBox(),
          )),
    );
  }
}
