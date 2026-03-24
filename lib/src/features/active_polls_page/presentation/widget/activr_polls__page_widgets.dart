import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/features/active_polls_page/presentation/widget/indicator.dart';
import 'package:poll_dao/src/features/widget_servers/repositories/storage_repository.dart';

import '../../../discover_page/data/models/poll_model.dart';

// Assuming the models for Poll, Author, Option, etc. are already defined and imported here.

class ActivePollsPageWidgets extends StatefulWidget {
  final Poll poll;

  const ActivePollsPageWidgets({super.key, required this.poll});

  @override
  State<ActivePollsPageWidgets> createState() => _ActivePollsPageWidgetsState();
}

class _ActivePollsPageWidgetsState extends State<ActivePollsPageWidgets> {
  var token = StorageRepository.getString("token");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 0, top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.poll.name,
                style: const TextStyle(fontSize: 17, color: AppColors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: AppColors.black.withValues(alpha: 0.3),
            ),
            Column(
              children: List.generate(1, (index) {
                return ChargePercentageIndicator(
                    chargePercentage: 11,
                    option: 'answerList[index]',
                    text: widget.poll.options[index].text??'',
                    selected: false);
              }),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${widget.poll.pollResult!.totalVotes ?? 0} Total Votes",
                style: const TextStyle(fontSize: 12, color: AppColors.c_111111, fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
