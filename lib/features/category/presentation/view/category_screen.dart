import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/categories/domain/entity/category_entity.dart';
import 'package:planitly/shared/widgets/app_bar.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryEntity category;

  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      appBar: CustomAppBar(title: widget.category.name),
    );
  }
}
