import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Chatbot/presentation/widgets/typing_dots.dart';

class MessageComponent extends StatelessWidget {
  final bool isUser;
  final String message;
  final bool isFailure;
  final VoidCallback? onRetry;
  final bool isLoading;

  MessageComponent({super.key, required this.isUser, required this.message, this.isFailure = false, this.onRetry, this.isLoading = false,});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: EdgeInsets.only(
            top: 4, bottom: 4, left: isUser? 50 : 8 , right: isUser ? 8 : 50),
        decoration: BoxDecoration(
          color: isUser ? Theme.of(context).appColors.primary : Theme.of(context).appColors.black16,
          borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: isUser ? Radius.circular(16) : Radius.circular(0),
              bottomRight: isUser ? Radius.circular(0) : Radius.circular(16),
        )),
        child: isFailure ? Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Failed to get response',
              style: Theme.of(context)
                  .appTexts
                  .bodySmall
                  .copyWith(color: Theme.of(context).appColors.black60),
            ),
            TextButton(
              onPressed: onRetry,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              child:  Text(
                'Try Again',
                style: Theme.of(context)
                    .appTexts
                    .bodySmall
                    .copyWith(color: Theme.of(context).appColors.primary))
            ),
          ],
        ) : isLoading
            ? const TypingDots()
            : Text(
          message,
          style: isUser ? Theme.of(context)
              .appTexts
              .bodySmall
              .copyWith(color: Theme.of(context).appColors.white100)
                  : Theme.of(context)
              .appTexts
              .bodySmall
              .copyWith(color: Theme.of(context).appColors.black87),
        ),
      ),
    );
  }
}
