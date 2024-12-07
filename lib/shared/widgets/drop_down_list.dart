import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class DropDownList extends StatefulWidget {
  final String hintText;
  final VoidCallback onPressed;
  final LayerLink layerLink;
  final IconData icon;

  const DropDownList({
    super.key,
    required this.hintText,
    required this.onPressed,
    required this.layerLink,
    this.icon = Icons.keyboard_arrow_down_outlined,
  });

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: widget.layerLink,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
                color: Theme.of(context).appColors.black16, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.hintText,
                style: Theme.of(context).appTexts.bodyMedium.copyWith(
                      color: Theme.of(context).appColors.black87,
                    ),
              ),
              Icon(
                widget.icon,
                color: Theme.of(context).appColors.black60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
