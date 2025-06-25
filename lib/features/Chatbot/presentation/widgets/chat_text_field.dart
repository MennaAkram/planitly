import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import '../../../../shared/assets.dart';

class ChatTextField extends StatelessWidget {
  final TextEditingController massageController;
  final VoidCallback onSendMessage;

  const ChatTextField({super.key, required this.massageController, required this.onSendMessage});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Theme.of(context).appColors.white100,
        height: 50,
        child: Row(
          children: [
            Expanded(
              flex: 12,
              child: Container(
                height: 38,
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextFormField(
                  minLines: 1,
                  controller: massageController,
                  style: Theme.of(context).appTexts.bodyMedium.copyWith(
                      color: Theme.of(context).appColors.black87),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).appColors.white100,
                    hintText: "Send massage",
                    hintStyle: Theme.of(context)
                        .appTexts
                        .labelMedium
                        .copyWith(
                        color: Theme.of(context).appColors.black37),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Theme.of(context).appColors.secondary,
                          width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide(
                          color: Theme.of(context).appColors.secondary,
                          width: 0.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                  ),
                  textInputAction: TextInputAction.send,
                  onFieldSubmitted: (_) => onSendMessage(),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                  onPressed: onSendMessage,
                  icon: SvgPicture.asset(Assets.sendicon)),
            )
          ],
        ),
      ),
    );
  }
}
