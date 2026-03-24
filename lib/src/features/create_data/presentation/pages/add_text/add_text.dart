import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/core/extentions/extentions.dart';
import 'package:poll_dao/src/core/icons/app_icons.dart';
import 'package:poll_dao/src/features/create_data/presentation/widgets/insert_text_image_fields.dart';
import 'package:poll_dao/src/features/create_data/presentation/widgets/insert_text_two_wariants.dart';
import 'package:poll_dao/src/features/create_poll/presentation/manager/cubits/index_cibit/index_cubit.dart';
import 'package:poll_dao/src/features/create_poll/presentation/widgets/add_options.dart';
import 'package:poll_dao/src/features/create_poll/presentation/widgets/select_question_type.dart';

class AddText extends StatefulWidget {
  const AddText({super.key});

  @override
  State<AddText> createState() => _AddTextState();
}

enum AnswerType { text, imageText }

class _AddTextState extends State<AddText> {
  List<TextEditingController> controllersData = [TextEditingController()];
  TextEditingController controller = TextEditingController();
  List<Widget> widgetList = <Widget>[];
  int index = 0;
  AnswerType? answerType;
  bool dataPoll = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: const Text("Add Text"),
      ),
      body: BlocProvider(
          create: (context) => IndexCubit(),
          child: BlocBuilder<IndexCubit, int>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    dataPoll
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.white,
                                ),
                                child: Column(
                                  children: widgetList,
                                )),
                          )
                        : Column(
                            children: widgetList,
                          ),
                    20.ph,
                    AddOptions(onTap: () async {
                      context.read<IndexCubit>().increment();
                      if (widgetList.isNotEmpty) {
                        switch (answerType!) {
                          case AnswerType.text:
                            widgetList.add(InsertTextTwoWariants(
                              controller: controllersData[state],
                              index: state,
                              onTap: () {
                                dataPoll = true;
                                debugPrint("dataPoll $dataPoll");
                              },
                            ));
                            controllersData.add(TextEditingController());
                            break;
                          case AnswerType.imageText:
                            widgetList.add(InsertTextImageFilds(
                              onTapOne: () {},
                              controller: controller,
                              count: state,
                            ));
                        }
                        setState(() {
                          dataPoll = false;
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
                                      widgetList.add(InsertTextTwoWariants(
                                        controller: controllersData[state],
                                        index: state,
                                        onTap: () {},
                                      ));
                                      controllersData.add(TextEditingController());
                                      // context.read<IndexCubit>().increment();
                                      setState(() {
                                        dataPoll = true;
                                      });
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
                                    onTap: () async {
                                      answerType = AnswerType.imageText;
                                      widgetList.add(InsertTextImageFilds(
                                        onTapOne: () {},
                                        controller: controller,
                                        count: state,
                                      ));
                                      // controllersData.add(TextEditingController());
                                      //context.read<IndexCubit>().increment();
                                      debugPrint("onTap Pop");
                                      Navigator.pop(context);
                                      setState(() {
                                        dataPoll = false;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    })
                  ],
                ),
              );
            },
          )),
    );
  }
}

/// /*  InsertTextFields(controllerList: controllersData, index: state, onTapTwo: () {  },),*/
