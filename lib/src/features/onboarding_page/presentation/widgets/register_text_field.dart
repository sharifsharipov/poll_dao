import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';

class RegisterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String textOne;
  final String textTwo;
  final String icon;
  const RegisterTextField({
    super.key,
    required this.controller,
    required this.textOne,
    required this.textTwo,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.c_5856D6.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(13),
                  child: SvgPicture.asset(icon),
                ),
              ),
              20.pw,
              Expanded(
                child: TextField(
                  maxLines: 1,
                  controller: controller,
                  style: const TextStyle(color: AppColors.secondary, fontSize: 24),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: textTwo,
                    hintText: textTwo,
                    hintStyle: const TextStyle(
                      color: AppColors.c_A0A4A7,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
