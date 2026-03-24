import 'package:flutter/material.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
class SelectCategoryContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  const SelectCategoryContainer(
      {super.key, required this.child, this.padding = const EdgeInsets.only(left: 12), required this.color});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ZoomTapAnimation(
      onTap: () {},
      child: Container(
        padding: padding,
        decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: child,
      ),
    );
  }
}
