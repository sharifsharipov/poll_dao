import 'package:flutter/material.dart';
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:poll_dao/src/features/discover_page/presentation/widgets/circle_avatar_with_name.dart';

import '../../data/models/poll_model.dart';

class OptionWidget extends StatelessWidget {
  final Option option;
  final int optionId;
  final bool select;
  final Function(int) onSelect;

  const OptionWidget({super.key, required this.option, required this.optionId, required this.select, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return option.image != null
      ? OptionImageButton(option: option, optionId: optionId, select: select, onSelect: onSelect,)
      : OptionTextButton(option: option, optionId: optionId, select: select, onSelect: onSelect,);
  }
}

Widget buildOptionsList(List<Option> options, int? selectedOptionId, Function(int) onSelection) {
  List<Widget> textOptions = [];
  List<Option> imageOptions = [];
  
  for (int i = 0; i < options.length; i++) {
    var option = options[i];
    
    if (option.image == null) {
      textOptions.add(OptionWidget(option: option, optionId: i, select: false, onSelect: onSelection));
      textOptions.add(const SizedBox(height: 5));
    } else {
      imageOptions.add(option);
    }
  }

  return Column(
    children: [
      if (imageOptions.isNotEmpty) buildImageOptionsGrid(imageOptions, onSelection),
      if (textOptions.isNotEmpty) ...textOptions,
    ],
  );
}


class OptionImageButton extends StatefulWidget {
  final Option option;
  final int optionId;
  final bool select;
  final Function(int) onSelect;
  
  const OptionImageButton({super.key, required this.option, required this.optionId, required this.select, required this.onSelect});

  @override
  State<OptionImageButton> createState() => _OptionImageButtonState();
}

class _OptionImageButtonState extends State<OptionImageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onSelect(widget.optionId),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: widget.select ? Colors.blue : Colors.transparent),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: FittedBox(
          fit: BoxFit.cover,
          child: Image.network("http://94.131.10.253:3000/${widget.option.image!}"),
        ),
      ),
    );
  }
}


class OptionTextButton extends StatefulWidget {
  final Option option;
  final int optionId;
  final bool select;
  final Function(int) onSelect;
  
  const OptionTextButton({super.key, required this.option, required this.select, required this.optionId, required this.onSelect});

  @override
  State<OptionTextButton> createState() => _OptionTextButtonState();
}

class _OptionTextButtonState extends State<OptionTextButton> {
  Color selectBackgroundColor = AppColors.c_5856D6;
  Color selectForegroundColor = AppColors.white;

  Color unselectBackgroundColor = AppColors.secondary;
  Color unselectForegroundColor = AppColors.black;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
    onPressed: () {
      widget.onSelect(widget.optionId);
    }, 
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(widget.select ? selectBackgroundColor : unselectBackgroundColor),
      foregroundColor: WidgetStateProperty.all(widget.select ? selectForegroundColor : unselectForegroundColor),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        )
      ),
      minimumSize: WidgetStateProperty.all(const Size(double.infinity, 45)),
      padding: WidgetStateProperty.all(const EdgeInsets.all(10.0)),
      shadowColor: WidgetStateProperty.all(Colors.transparent)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
          if (widget.optionId == 0) const AvatarWithName(
            name: "A", 
            radius: 16, 
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.c_5856D6 
          ) else if (widget.optionId == 1) const AvatarWithName(
            name: "B", 
            radius: 16, 
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.c_5856D6
          ) else const AvatarWithName(
            name: "C", 
            radius: 16, 
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.c_5856D6
          )
          ,
          const SizedBox(width: 10),
          Text(widget.option.text??'')
          ]
        ),
        Text(widget.select ? "12 %" : "")
      ],
    )
  );
  }
}

Widget buildImageOptionsGrid(List<Option> imageOptions, Function(int) onSelect) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: imageOptions.length == 1 ? 1 : 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 1.0,
    ),
    itemCount: imageOptions.length,
    itemBuilder: (BuildContext context, int index) {
      return OptionImageButton(
        option: imageOptions[index],
        optionId: index,
        select: false,
        onSelect: onSelect,
      );
    },
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(), // to disable GridView's own scrolling
    padding: const EdgeInsets.all(10),
  );
}