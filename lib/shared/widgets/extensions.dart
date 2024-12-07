import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/widgets/button.dart';

extension ContextExtension on BuildContext {
  void showCustomSnackBar(String message) {
    AnimationController controller;
    Animation<Offset> positionAnimation;
    final overlay = Overlay.of(this);
    controller = AnimationController(
      vsync: overlay,
      duration: const Duration(milliseconds: 500),
    );

    positionAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOut,
    ));

    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
        builder: (context) => AnimatedBuilder(
              animation: controller,
              builder: (context, child) => Positioned(
                  top: (MediaQuery.of(context).viewInsets.top + 50) *
                      controller.value,
                  child: SlideTransition(
                    position: positionAnimation,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width * .96,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Theme.of(context).appColors.background,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 4,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .65,
                              child: Text(
                                message,
                                textAlign: TextAlign.right,
                                style: Theme.of(context)
                                    .appTexts
                                    .titleSmall
                                    .copyWith(
                                      color:
                                          Theme.of(context).appColors.primary,
                                    ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
    overlay.insert(overlayEntry);
    controller.forward();
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      await controller.reverse();
      overlayEntry.remove();
    });
  }

  Future alertDialog(
    String title,
    String firstButtonText,
    String secondButtonText,
    Function onClickFirstButton,
    Function onClickSecondButton,
    Widget widget,
  ) async {
    await showGeneralDialog(
      context: this,
      barrierLabel: 'Barrier',
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, __, ___) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: Theme.of(context).appColors.background,
                  borderRadius: BorderRadius.circular(12)),
              child: Material(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  width: double.infinity,
                  child: SingleChildScrollView(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).appTexts.titleSmall.copyWith(
                                color: Theme.of(context).appColors.black87,
                              )),
                      const SizedBox(
                        height: 16,
                      ),
                      widget,
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              verticalPadding: 12,
                              text: firstButtonText,
                              onPressed: () => onClickFirstButton(),
                              outlined: false,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: CustomButton(
                              verticalPadding: 12,
                              text: secondButtonText,
                              onPressed: () => onClickSecondButton(),
                              outlined: true,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
              ),
            ),
          );
        });
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(-1, 0), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }
}
