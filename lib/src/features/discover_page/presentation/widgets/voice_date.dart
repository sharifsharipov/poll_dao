import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:poll_dao/src/core/icons/app_icons.dart';
import '../../../../core/colors/app_colors.dart';
class VoiceData extends StatefulWidget {
  final String textOne;
  final String textTwo;
  final String textThree;
  final String nameText;
  final VoidCallback onTapTwo;
  const VoiceData(
      {super.key,
      required this.textOne,
      required this.textTwo,
      required this.nameText,
      required this.onTapTwo,
      required this.textThree});

  @override
  State<VoiceData> createState() => _VoiceDataState();
}

class _VoiceDataState extends State<VoiceData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    height: 30,
                    width: 30,
                    //margin: const EdgeInsets.all(15) ,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), color: AppColors.c_C8E8FA),
                    child: Center(child: Text(widget.nameText))),
                const Gap(10),
                Text(
                  widget.textOne,
                  style: const TextStyle(
                      fontSize: 17, color: AppColors.c_02182B, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  widget.textTwo,
                  style: const TextStyle(
                      fontSize: 17, color: AppColors.c_93A2B4, fontWeight: FontWeight.w500),
                ),
                const Gap(10),
                IconButton(onPressed: widget.onTapTwo, icon: SvgPicture.asset(AppImages.artboard))
              ],
            ),
          ],
        ),
        10.ph,
        Divider(
          color: AppColors.black.withValues(alpha: 0.3),
          height: 1,
        ),
        20.ph,
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.textThree,
            style: const TextStyle(
                fontSize: 12, color: AppColors.c_5B6D83, fontWeight: FontWeight.w500),
          ),
        ),
        5.ph,
      ],
    );
  }
}
