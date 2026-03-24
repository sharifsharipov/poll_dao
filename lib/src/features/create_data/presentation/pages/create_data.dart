import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:poll_dao/src/core/icons/app_icons.dart';
import 'package:poll_dao/src/features/create_data/presentation/widgets/insert_text_image_fields.dart';
import 'package:poll_dao/src/features/create_data/presentation/widgets/insert_text_widgets.dart';

import 'package:poll_dao/src/features/create_poll/presentation/manager/cubits/index_cibit/index_cubit.dart';
import 'package:poll_dao/src/features/create_poll/presentation/widgets/add_options.dart';
import 'package:poll_dao/src/features/create_poll/presentation/widgets/select_question_type.dart';

class CreateData extends StatefulWidget {
  const CreateData({super.key});

  @override
  State<CreateData> createState() => _CreateDataState();
}

enum AnswerType { text, imageText }

class _CreateDataState extends State<CreateData> {
  List<TextEditingController> controller = [TextEditingController()];
  List<Widget> widgetList = <Widget>[];
  int index = 0;
  List<File> imageFiles = [];
  final pickImage = ImagePicker();
  AnswerType? answerType;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: const Text("Create Data"),
      ),
      body: BlocProvider(
        create: (context) => IndexCubit(),
        child: BlocBuilder<IndexCubit, int>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // InsertTextFields(controllerList: controller, index: index,  onTapTwo: (){}),
                  ...widgetList,
                  20.ph,
                  AddOptions(
                    onTap: () async {
                      if (widgetList.isNotEmpty) {
                        switch (answerType!) {
                          case AnswerType.text:
                            InsertTextFields(
                                controllerList: controller, index: index, onTapTwo: () {});
                            controller.add(TextEditingController());
                            break;
                          case AnswerType.imageText:
                            widgetList.add(InsertTextImageFilds(
                              onTapOne: () {},
                              controller: controller[state],
                              count: state,
                            ));
                        }
                        setState(() {

                        });
                        return;
                      }
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.only(right: width / 3),
                              child: CupertinoActionSheet(
                                actions: <Widget>[
                                  0.1.ph,
                                  SelectQuestionWidget(
                                    text: "Text",
                                    data: const [
                                      Text(
                                        "Aa",
                                        style: TextStyle(
                                          color: AppColors.c_111111,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                    onTap: () async {
                                      answerType = AnswerType.text;
                                      widgetList.add(InsertTextFields(
                                        controllerList: controller,
                                        index: state,
                                        onTapTwo: () {},
                                      ));
                                      controller.add(TextEditingController());
                                      //context.read<IndexCubit>().increment();
                                      setState(() {});
                                      debugPrint("onTap Pop");
                                      Navigator.pop(context);
                                    },
                                  ),
                                  0.1.ph,
                                  SelectQuestionWidget(
                                    text: 'Text+Image',
                                    data: [
                                      const Text(
                                        "Aa",
                                        style: TextStyle(
                                          color: AppColors.c_111111,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SvgPicture.asset(AppImages.imageSelect),
                                    ],
                                    onTap: () {
                                      answerType = AnswerType.imageText;
                                      widgetList.add(InsertTextImageFilds(
                                        onTapOne: () {},
                                        controller: controller[state],
                                        count: state,
                                      ));
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  /*    AddOptions(
                    onTap: () {
                      controller.add(TextEditingController());
                      widgetList.add(InsertTextImageFilds(
                        onTapOne: () {},
                        controller: controller[state],
                        count: state,
                      ));
                      context.read<IndexCubit>().increment();
                    },
                  ),*/
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
