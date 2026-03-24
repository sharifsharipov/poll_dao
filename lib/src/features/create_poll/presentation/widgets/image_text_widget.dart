import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/features/create_poll/presentation/manager/cubits/index_cibit/index_cubit.dart';
import 'package:poll_dao/src/features/create_poll/presentation/widgets/image_data_text_field.dart';

class BaseNewPoll extends StatefulWidget {
  const BaseNewPoll({
    super.key,
    required this.hintText,
  });

  final String hintText;

  @override
  State<BaseNewPoll> createState() => _BaseNewPollState();
}

class _BaseNewPollState extends State<BaseNewPoll> {
  List<TextEditingController> textControllers = [TextEditingController()];
  late List<File?> imageFiles; // List to store images for each text field
  final pickImage = ImagePicker();

  @override
  void initState() {
    super.initState();
    textControllers = [TextEditingController()];
    imageFiles = [null];
  }

  Future pickImageFromGallery(int index) async {
    final image = await pickImage.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image == null) return;
    setState(() {
      imageFiles[index] = File(image.path);
    });
  }

  @override
  void dispose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IndexCubit(),
      child: Padding(
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
                      if (index == textControllers.length - 1 && value.isNotEmpty) {
                        setState(() {
                          textControllers.add(TextEditingController());
                          imageFiles
                              .add(null);
                        });
                      }
                    },
                    hintText: widget.hintText,
                    answer: answerListImage[index],
                    onTapOne: () {},
                    onTapTwo: () {},
                    onTapThree: () {},
                  ),
                  InkWell(
                    onTap: () {
                      pickImageFromGallery(
                          index); // Pass the index to identify the corresponding text field
                    },
                    child: Container(
                      height: 200,
                      width: 350,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 4.0),
                        borderRadius: BorderRadius.circular(
                            15.0), // Adjusted border radius to match the container
                      ),
                      child: imageFiles[index] != null
                          ? Image.file(
                              imageFiles[index]!.absolute,
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: Icon(Icons.add_photo_alternate_outlined, size: 60),
                            ),
                    ),
                  ),
                ],
              );
            },
            itemCount: textControllers.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

List<String> answerListImage = [
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
List<TextEditingController> controllers = [
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
];

/* Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Container(
                    height: (height / 35),
                    width: (height / 35),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.c_C8E8FA.withOpacity(0.3)),
                    child:  Center(
                        child: Text(
                          widget.answer,
                          style: const TextStyle(
                              color: AppColors.c_5856D6, fontWeight: FontWeight.bold),
                        )),
                  ),
                  (width / 30).pw,
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Insert text',
                          hintStyle: const TextStyle(
                              color: AppColors.c_93A2B4,
                              fontWeight: FontWeight.normal,fontSize: 17),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: widget.onTapOne,
                            icon: SvgPicture.asset(
                              AppImages.cancel,
                              height: (height / 40),
                            ),
                          )),
                    ),
                  ),
                  IconButton(
                      onPressed: widget.onTapTwo, icon: SvgPicture.asset(AppImages.menu,width: 30,))
                ],
              ),
            ),
            (height / 40).ph,
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 20),
              height: (height / 4.8),
              width: width,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Image.asset(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                  IconButton(
                      onPressed: widget.onTapThree, icon: SvgPicture.asset(AppImages.cancel))
                ],
              ),
            )*/
