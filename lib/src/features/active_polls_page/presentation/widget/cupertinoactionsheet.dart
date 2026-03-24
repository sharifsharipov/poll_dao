import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';

class CupertinoActionSheetActionWidget extends StatelessWidget {
  const CupertinoActionSheetActionWidget({super.key, required this.onPressed, required this.text});
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.67,left: MediaQuery.of(context).size.width * 0.05,right: MediaQuery.of(context).size.width * 0.05,bottom: MediaQuery.of(context).size.height * 0.01),
      child: CupertinoActionSheet(
        title:  Text('You are about to delete this poll.',style: TextStyle(fontSize: 17,color: AppColors.c_111111.withValues(alpha: 0.3),fontWeight: FontWeight.w500),),
        actions: [
          CupertinoActionSheetAction(
            onPressed: onPressed,
            isDefaultAction: true,
            child: Text(
              text,
              style: const TextStyle(color: Colors.red, fontSize: 17),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text(
            'Cancel',
            style: TextStyle(color: AppColors.c_5856D6, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
