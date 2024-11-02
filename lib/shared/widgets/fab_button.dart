import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const AddButton({super.key, required this.onPressed, this.icon = Icons.add});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Theme.of(context).appColors.primary,
      elevation: 0,
      child: Icon(
        icon,
        color: Theme.of(context).appColors.white87,
      ),
    );
  }
}
