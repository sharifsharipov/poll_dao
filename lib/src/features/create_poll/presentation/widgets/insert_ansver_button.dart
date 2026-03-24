import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/features/create_poll/presentation/widgets/image_data_text_field.dart';

class InsertAnswer extends StatefulWidget {
  const InsertAnswer({
    super.key,
    required this.hintText,
  });
  final String hintText;

  @override
  State<InsertAnswer> createState() => _InsertAnswerState();
}

class _InsertAnswerState extends State<InsertAnswer> {
  List<TextEditingController> textControllers = [];

  @override
  void initState() {
    super.initState();
    textControllers.add(TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in textControllers) {
      controller.text = '';
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("UI qayta yozildi");
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.white,
        ),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            debugPrint("TextControllers length: ${textControllers[index].text}");
            return Column(
              children: [
                ImageDataTextField(
                  controller: textControllers[index],
                  onChanged: (value) {
                    if (value.isNotEmpty && index == textControllers.length - 1) {
                      setState(() {
                        textControllers.add(TextEditingController());
                      });
                    }
                  },
                  hintText: widget.hintText,
                  answer: answerList[index],
                  onTapOne: () {},
                  onTapTwo: () {},
                  onTapThree: () {},
                ),
                if (index != textControllers.length - 1)
                  Padding(
                    padding: EdgeInsets.only(left: width / 8, right: width / 42.6),
                    child: const Divider(height: 1, color: AppColors.c_A0A4A7),
                  ),
              ],
            );
          },
          itemCount: textControllers.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }
}

List<String> answerList = [
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "H",
  "I",
  "J",
  "K",
  "L",
  "M",
  "N",
  "O",
  "P",
  "Q",
  "R",
  "S",
  "T",
  "U",
  "V",
  "W",
  "X",
  "Y",
  "Z"
];



/*  int count = 1;
  List<TextEditingController> textControllers = [];
  List<VoidCallback> onTapsOne = [];
  List<VoidCallback> onTapsTwo = [];
  List<VoidCallback> onTapsThree = [];
  List<ValueChanged> onChanged   = [];
  @override
  void initState() {
      textControllers.add(TextEditingController());
      onTapsOne.add(() {});
      onTapsTwo.add(() {});
      onTapsThree.add(() {});

    super.initState();
  }*/

