import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:poll_dao/src/features/onboarding_page/presentation/widgets/questions.dart';
import '../../../../core/colors/app_colors.dart';

class OnboardingWidgetOne extends StatelessWidget {
  const OnboardingWidgetOne({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    //EdgeInsets.only(top: height * 0.15),
    return Scaffold(
      backgroundColor: AppColors.secondary.withValues(alpha: 0.9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            120.ph,
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Text(
                    "Visually Appealing",
                    style: TextStyle(
                        fontSize: 34, fontWeight: FontWeight.bold, color: AppColors.black),
                  ),
                  const Text(
                    "Enhance with visuals; limitless",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.c_93A2B4),
                  ),
                  const Text(
                    "creativity, endless options.",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.c_93A2B4),
                  ),
                  30.ph,
                  const QuestionsOne()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
