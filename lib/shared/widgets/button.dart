import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool outlined;
  final VoidCallback onPressed;
  final IconData icon;
  final bool addIcon;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.outlined,
      this.icon = Icons.add,
      this.addIcon = false});

  @override
  Widget build(BuildContext context) {
    return
    ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: outlined
            ? Color(0xFFFFFFFF)
            : Color(0xFFFC5D00),
        padding: EdgeInsets.symmetric(
            horizontal: addIcon ? 12 : 48 , vertical: addIcon ? 8 : 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
          side: BorderSide(
            color: Color(0xFFFC5D00),
            width: 0.5,
          ),
        ),
      ),
      // ignore: sized_box_for_whitespace
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addIcon
                ? Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: Icon(
                      icon,
                      color: Color(0xFFFC5D00),
                      size: 16,
                    ),
                  )
                : const SizedBox(),
            Text(
              text,
              style: (addIcon
                      ? Theme.of(context).textTheme.bodySmall
                      : Theme.of(context).textTheme.titleSmall)
                  ?.copyWith(
                color: outlined
                    ? Color(0xFFFC5D00)
                    : Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
    );
  }
}
                  
