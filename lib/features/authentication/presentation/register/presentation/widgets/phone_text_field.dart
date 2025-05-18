import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:planitly/design_system/theme.dart';

class PhoneNumberTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final void Function(String,String)? onChanged;

  const PhoneNumberTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      validator: (phone) => validator?.call(phone?.number),
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.phone,
      initialCountryCode: 'EG',
      flagsButtonMargin: const EdgeInsets.symmetric(horizontal: 8),
      showDropdownIcon: true,
      disableLengthCheck: true,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context)
          .appTexts
          .bodyMedium
          .copyWith(color: Theme.of(context).appColors.black60),
      dropdownTextStyle: Theme.of(context)
          .appTexts
          .bodyMedium
          .copyWith(color: Theme.of(context).appColors.black60),
      decoration: InputDecoration(
        counterText: '',
        filled: true,
        fillColor: Theme.of(context).appColors.white87,
        hintText: labelText,
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
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
      ),
      dropdownIcon: Icon(
        Icons.keyboard_arrow_down,
        color: Theme.of(context).appColors.black87,
      ),
      onChanged: (phone) {
        if (onChanged != null) {
          onChanged!(phone.countryCode, phone.number);
        }
      },
    );
  }
}
