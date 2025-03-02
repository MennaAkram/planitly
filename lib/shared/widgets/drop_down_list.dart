import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class DropDownList extends StatefulWidget {
  final String hintText;
  final double offset;
  final IconData icon;
  final List<String> menuItems;
  final Function(String)? onItemSelected;

  const DropDownList({
    super.key,
    required this.hintText,
    required this.menuItems,
    this.offset = 1,
    this.icon = Icons.keyboard_arrow_down,
    this.onItemSelected,
  });

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  late String _selectedItem = widget.hintText;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(onSelected: (value) {
      widget.onItemSelected?.call(value);
      setState(() {
        _selectedItem = value;
      });
    }, itemBuilder: (context) {
      return List<PopupMenuEntry<String>>.generate(widget.menuItems.length,
              (index) {
            final item = widget.menuItems[index];
            return PopupMenuItem<String>(
              value: item,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item,
                    style: Theme.of(context).appTexts.bodyMedium.copyWith(
                      color: Theme.of(context).appColors.black60,
                    ),
                  ),
                if ( item != widget.menuItems.last)
                  Divider(
                    color: Theme.of(context).appColors.secondary,
                  )
                ],
              ),
            );
          });
    },
      offset: Offset(widget.offset, 35),
      tooltip: "",
      color: Theme.of(context).appColors.background,
      splashRadius: 0,
      elevation: 0,
      constraints: const BoxConstraints(
        maxWidth: 120,
        maxHeight: 200,
      ),
      shape: RoundedRectangleBorder(
        side:BorderSide(
          color: Theme.of(context).appColors.black16,
          width: 0.5,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.zero,
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border:
          Border.all(color: Theme.of(context).appColors.black16, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedItem,
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
    );
  }

}
