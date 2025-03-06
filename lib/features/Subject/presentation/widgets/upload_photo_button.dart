import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planitly/design_system/theme.dart';


class UploadPhotoButton extends StatelessWidget {
  final Function onPressed;
  final XFile? image;
  final String text;
  const UploadPhotoButton({
    super.key,
    required this.onPressed,
    this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: SizedBox(
        height: 90,
        child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_a_photo),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        text,
                        style: Theme.of(context).appTexts.labelLarge.copyWith(
                              color: Theme.of(context).appColors.black60,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
