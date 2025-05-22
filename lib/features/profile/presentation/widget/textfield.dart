import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

// ignore: must_be_immutable
class text_field extends StatelessWidget {
  final TextEditingController controller;
  String title;
  text_field({super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: Theme.of(context)
            .appTexts
            .bodyMedium
            .copyWith(color: Theme.of(context).appColors.black60),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide:
              BorderSide(color: Theme.of(context).appColors.black16, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide:
              BorderSide(color: Theme.of(context).appColors.black16, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide:
              BorderSide(color: Theme.of(context).appColors.black16, width: 1),
        ),
      ),
    );
  }
}
