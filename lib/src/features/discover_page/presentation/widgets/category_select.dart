import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:poll_dao/src/core/colors/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../data/models/data_cetegory_model.dart';


class CategoryProvider with ChangeNotifier {
  int? _selectedCategoryId;

  int? get selectedCategoryId => _selectedCategoryId;

  set selectedCategoryId(int? id) {
    _selectedCategoryId = id;
    debugPrint("set selected category $id");
    notifyListeners();  // Уведомить слушателей об изменении
  }
}


class SelectCategory extends StatefulWidget {
  const SelectCategory({
    super.key,
    required this.selectColor,
  });

  final bool selectColor;

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  Future<List<DataCategoryModel>> categories = fetchCategories();

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context, listen: false);

    return FutureBuilder<List<DataCategoryModel>>(
      future: categories,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          return Wrap(
            children: List.generate(
              data.length,
              (index) {
                final item = data[index];
                return CategorieChip(
                  id: item.id,
                  title: item.name,
                  select: item.id == categoryProvider.selectedCategoryId,
                  onSelectionChanged: () {
                    setState(() {
                      if (categoryProvider.selectedCategoryId == item.id) {
                        categoryProvider.selectedCategoryId = null;
                      } else {
                        categoryProvider.selectedCategoryId = item.id;
                      }
                    });
                  },
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}

Future<List<DataCategoryModel>> fetchCategories() async {
  final response = await http.get(Uri.parse('http://94.131.10.253:3000/public/topics'));

  if (response.statusCode == 200) {
    final List<dynamic> dataJson = jsonDecode(response.body);
    List<DataCategoryModel> data = dataJson.map((json) => DataCategoryModel.fromJson(json)).toList();
    return data;
  } else {
    throw Exception('Failed to load data');
  }
}

class CategorieChip extends StatefulWidget {
  final bool select;
  final String title;
  final int id;
  final VoidCallback onSelectionChanged;

  const CategorieChip({
    super.key,
    required this.select,
    required this.title,
    required this.id,
    required this.onSelectionChanged,
  });

  @override
  State<CategorieChip> createState() => _CategorieChipState();
}

class _CategorieChipState extends State<CategorieChip> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.5),
      child: GestureDetector(
        onTap: widget.onSelectionChanged,
        child: ZoomTapAnimation(
          child: Chip(
            label: Text(
              widget.title,
              style: TextStyle(
                color: widget.select ? AppColors.white : AppColors.c_5856D6,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            side: BorderSide.none,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            backgroundColor: widget.select ? AppColors.c_5856D6 : AppColors.c_F0F3FA,
          ),
        ),
      ),
    );
  }
}
