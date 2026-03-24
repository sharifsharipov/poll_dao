import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:poll_dao/src/core/icons/app_icons.dart';
import 'package:poll_dao/src/features/create_poll/presentation/widgets/text_widget.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({
    super.key,
    required this.onTap,
    required this.title,
    required this.subTitle,
    required this.hint,
  });
  final VoidCallback onTap;
  final String title;
  final String subTitle;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(alignment: Alignment.centerLeft, child: customTextWidget(text: title, color: AppColors.black)),
        10.ph,
        InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    subTitle.isEmpty ? hint : subTitle,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: subTitle.isEmpty ? AppColors.c_5B6D83 : AppColors.black),
                  ),
                ),
                SvgPicture.asset(AppImages.lowIosButton, height: 16, width: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
