import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/features/active_polls_page/presentation/widget/indicator_two.dart';

class ActivePollsPageWidgetsTwo extends StatefulWidget {
  const ActivePollsPageWidgetsTwo({super.key});

  @override
  State<ActivePollsPageWidgetsTwo> createState() => _ActivePollsPageWidgetsTwoState();
}

class _ActivePollsPageWidgetsTwoState extends State<ActivePollsPageWidgetsTwo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "LAST VOTED 1 MINUTE AGO ",
                style:
                TextStyle(fontSize: 12, color: AppColors.c_111111, fontWeight: FontWeight.w400),
              ),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Which way would you choose for your \tnext vacation?",
                style: TextStyle(fontSize: 17, color: AppColors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: AppColors.black.withValues(alpha: 0.3),
            ),
            const ChargePercentageIndicatorTwo(
                chargePercentage: 30, option:"assets/images/img_1.png", text: 'Netflix & Chill 🍿'),
            const ChargePercentageIndicatorTwo(
                chargePercentage: 69, option: "assets/images/img_1.png", text: ' 38 Votes'),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "55 Total Votes",
                style:
                TextStyle(fontSize: 12, color: AppColors.c_111111, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
