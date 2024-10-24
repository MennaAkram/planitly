import 'package:flutter/material.dart';
import 'package:planitly/design_system/app_colors.dart';
import 'package:planitly/design_system/app_text.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField(
      {super.key,
      required this.labelText,
      this.isPassword = false,
      this.validator,
      required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _showPassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: _showPassword,
        keyboardType:
            widget.isPassword ? TextInputType.text : TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: AppColorsTheme.light().white87,
          labelText: widget.labelText,
          labelStyle: AppTextsTheme.main().bodyMedium.copyWith(
                color: AppColorsTheme.light().black37,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide:
                BorderSide(color: AppColorsTheme.light().black16, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide:
                BorderSide(color: AppColorsTheme.light().black16, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide:
                BorderSide(color: AppColorsTheme.light().black16, width: 1),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                      !_showPassword
                          ? Icons.visibility_off_outlined
                          : Icons.remove_red_eye_outlined,
                      color: AppColorsTheme.light().black60,
                      size: 20),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14.5),
        ),
      ),
    );
  }
}
