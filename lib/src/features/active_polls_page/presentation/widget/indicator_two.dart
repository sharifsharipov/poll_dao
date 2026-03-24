import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class ChargePercentageIndicatorTwo extends StatefulWidget {
  final int chargePercentage;
  final String option;
  final String text;

  const ChargePercentageIndicatorTwo(
      {super.key, required this.chargePercentage, required this.option, required this.text});

  @override
  State<ChargePercentageIndicatorTwo> createState() => _ChargePercentageIndicatorTwoState();
}

class _ChargePercentageIndicatorTwoState extends State<ChargePercentageIndicatorTwo> {
  bool tap = true;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ZoomTapAnimation(
      onTap: () {
        tap = !tap;
        setState(() {
          if (tap) {
            count++;
          } else {
            count--;
          }
        });
      },
      child: SizedBox(
        width: width,
        child: Row(
          children: [
            Image.asset(
              widget.option,
              width: 40,
              height: 40,
            ),
            (width / 30).pw,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: (width / 1.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.text,
                        style: const TextStyle(fontSize: 17),
                      ),
                      Text(
                        '${widget.chargePercentage + count}%', // $chargePercentage o'rniga chargePercentage.toString() + '%' ishlatish
                        style: const TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.normal),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 270,
                  height: 15,
                  child: LinearProgressIndicator(
                    borderRadius: BorderRadius.circular(5),
                    backgroundColor: Colors.transparent,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(tap ? AppColors.c_5B6D83.withValues(alpha: 0.1) : AppColors.c_5856D6),
                    value: widget.chargePercentage / 100.0,
                  ),
                ),
                20.ph,
              ],
            )
          ],
        ),
      ),
    );
  }
}
