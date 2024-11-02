import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final IconData passwordVisibleIcon;
  final IconData passwordHiddenIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    this.isPassword = false,
    this.passwordVisibleIcon = Icons.visibility_off_outlined,
    this.passwordHiddenIcon = Icons.remove_red_eye_outlined,
    this.validator,
  });

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
          fillColor: Theme.of(context).appColors.white87,
          labelText: widget.labelText,
          labelStyle: Theme.of(context).appTexts.bodyMedium.copyWith(
                color: Theme.of(context).appColors.black37,
              ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
                color: Theme.of(context).appColors.black16, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
                color: Theme.of(context).appColors.black16, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
                color: Theme.of(context).appColors.black16, width: 1),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                      !_showPassword
                          ? widget.passwordVisibleIcon
                          : widget.passwordHiddenIcon,
                      color: Theme.of(context).appColors.black60,
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
