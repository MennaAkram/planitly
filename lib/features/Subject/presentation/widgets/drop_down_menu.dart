import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class DropDownMenu {
  static OverlayEntry createOverlayEntry(
    BuildContext context,
    LayerLink layerLink,
    List<String> data,
    void Function(String) onItemSelected,
  ) {
    final scrollController = ScrollController();

    late OverlayEntry? overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: () {
              overlayEntry?.remove();
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            width: 120,
            child: CompositedTransformFollower(
              link: layerLink,
              offset: const Offset(0, 50),
              showWhenUnlinked: false,
              child: Material(
                clipBehavior: Clip.hardEdge,
                elevation: 4.0,
                color: Theme.of(context).appColors.white100,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: SizedBox(
                  height: 250,
                  child: ScrollbarTheme(
                    data: ScrollbarThemeData(
                      thumbColor: WidgetStateProperty.all(
                          Theme.of(context).appColors.black16),
                      thickness: WidgetStateProperty.all(4),
                      radius: const Radius.circular(16),
                    ),
                    child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: false,
                      scrollbarOrientation: ScrollbarOrientation.left,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: data.length,
                        separatorBuilder: (context, index) => Divider(
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                          color: Theme.of(context).appColors.secondary,
                        ),
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              data[index],
                              style: Theme.of(context)
                                  .appTexts
                                  .bodyMedium
                                  .copyWith(
                                    color: Theme.of(context).appColors.black60,
                                  ),
                            ),
                            onTap: () => onItemSelected(data[index]),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return overlayEntry;
  }
}
