import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';

import '../../../../../core/colors/app_colors.dart';

class OnboardingWidgetTwot extends StatefulWidget {
  const OnboardingWidgetTwot({super.key});

  @override
  State<OnboardingWidgetTwot> createState() => _OnboardingWidgetTwoState();
}

class _OnboardingWidgetTwoState extends State<OnboardingWidgetTwot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary.withValues(alpha: 0.9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            120.ph,
            myTextWidget(),
            30.ph,
            Stack(children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Image.asset("assets/images/hexagon.png"),
              ),
            ],)
          ],
        ),
      ),
    );
  }
  Widget myTextWidget(){
    return  const Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            "Engaging Pols",
            style: TextStyle(
                fontSize: 34, fontWeight: FontWeight.bold, color: AppColors.black),
          ),
          Text(
            "Craft your polls,unlock a world of",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.c_93A2B4),
          ),
          Text(
            "option with multiple choices.",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.c_93A2B4),
          ),
        ],
      ),
    );
  }
}
