import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/features/onboarding_page/presentation/widgets/my_widgets/onboarding_widget_two.dart';
import 'package:poll_dao/src/features/onboarding_page/presentation/widgets/onboarding_two_widget.dart';
import 'package:poll_dao/src/features/onboarding_page/presentation/widgets/onboarding_widget_three.dart';

import '../widgets/onboarding_one_widget.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.secondary.withValues(alpha: 0.9),
      body: Column(
        children: [
           SizedBox(
             height: height,
             child:
               Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return pageCount[index];
                  },
                  itemCount: pageCount.length,
                  pagination: const SwiperPagination(),
                  // control: SwiperControl(),
                ),
           ),
        
        ],
      ),
    );
  }
}
List pageCount=[
  const OnboardingWidgetOne(),
  const OnboardingWidgetTwo(),
  const OnboardingWidgetThree(),
  const OnboardingWidgetTwot(),

];