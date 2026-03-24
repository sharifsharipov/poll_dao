import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
class BaseContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const BaseContainer(
      {super.key, required this.child, this.padding = const EdgeInsets.only(left: 12)});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ZoomTapAnimation(
      onTap: () {},
      child: Container(
        padding: padding,
        decoration:
            BoxDecoration(color: AppColors.c_F0F3FA, borderRadius: BorderRadius.circular(20)),
        child: child,
      ),
    );
  }
}
