import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:poll_dao/src/features/onboarding_page/presentation/widgets/question_two/questions_two.dart';
import '../../../../core/colors/app_colors.dart';
class OnboardingWidgetTwo extends StatelessWidget {
  const OnboardingWidgetTwo({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                    "Engaging Pols",
                    style: TextStyle(
                        fontSize: 34, fontWeight: FontWeight.bold, color: AppColors.black),
                  ),
                  const Text(
                    "Craft your polls,unlock a world of",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.c_93A2B4),
                  ),
                  const Text(
                    "option with multiple choices.",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.c_93A2B4),
                  ),
                  30.ph,
                  const QuestionsTwo()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
