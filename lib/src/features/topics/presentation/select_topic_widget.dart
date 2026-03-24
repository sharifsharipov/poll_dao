import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/features/topics/logic/topic_notifier.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class SelectTopicWidget extends StatelessWidget {
  const SelectTopicWidget({super.key, this.selectedIndex, this.onSelected, this.isValidated = true});
  final int? selectedIndex;
  final ValueChanged<int>? onSelected;
  final bool isValidated;

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<TopicNotifier>();
    if (notifier.isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 5,
              runSpacing: 5,
              children: List.generate(
                notifier.topics.length,
                (index) => TopicChip(
                  title: notifier.topics[index].name,
                  selectColor: selectedIndex == notifier.topics[index].id,
                  onTap: () => onSelected?.call(notifier.topics[index].id),
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (!isValidated) const ValidationErrorText(text: 'Topic is required'), 
          ],
        ),
      );
    }
  }
}

class ValidationErrorText extends StatelessWidget {
  const ValidationErrorText({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.red),
    );
  }
}

class TopicChip extends StatelessWidget {
  const TopicChip({
    super.key,
    required this.onTap,
    required this.selectColor,
    required this.title,
  });

  final VoidCallback onTap;
  final bool selectColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: selectColor ? AppColors.c_5856D6 : AppColors.secondary,
        ),
        child: Text(title,
            style: TextStyle(
              color: selectColor ? Colors.white : AppColors.c_5856D6,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              height: 1.3,
            )),
      ),
    );
  }
}
