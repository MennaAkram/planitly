import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assets.dart';

class DateTextField extends StatefulWidget {
  final String labelText;
  final String icon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const DateTextField({
    super.key,
    required this.labelText,
    this.icon = Assets.iconCalender,
    required this.controller,
    this.validator,
  });

  @override
  State<DateTextField> createState() => _DateTextFieldState();
}

class _DateTextFieldState extends State<DateTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime(
            DateTime.now().year - 13,
            DateTime.now().month,
            DateTime.now().day,
          ),
          firstDate: DateTime(1900, 1, 1),
          lastDate: DateTime(
            DateTime.now().year - 13,
            DateTime.now().month,
            DateTime.now().day,
          ),
        );
        if (date != null) {
          widget.controller.text = DateFormat("MMM dd, yyyy").format(date);
        }
      },
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).appColors.white87,
        hintText: widget.labelText,
        hintStyle: Theme.of(context).appTexts.bodyMedium.copyWith(
              color: Theme.of(context).appColors.black37,
            ),
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
        suffixIcon: IconButton(
          iconSize: 24,
          icon: SvgPicture.asset(
            widget.icon,
            colorFilter: ColorFilter.mode(
              Theme.of(context).appColors.black60,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime(
                DateTime.now().year - 13,
                DateTime.now().month,
                DateTime.now().day,
              ),
              firstDate: DateTime(1900),
              lastDate: DateTime(
                DateTime.now().year - 13,
                DateTime.now().month,
                DateTime.now().day,
              ),
            );
            if (date != null) {
              widget.controller.text = DateFormat("MMM dd, yyyy").format(date);
            }
          },
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
      ),
    );
  }
}
