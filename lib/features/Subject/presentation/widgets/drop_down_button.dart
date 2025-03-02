// import 'package:flutter/material.dart';
// import 'package:planitly/design_system/theme.dart';
//
// class DropDownButton extends StatefulWidget {
//   final String hintText;
//   final double offset;
//   final IconData icon;
//   final List<String> menuItems;
//   final Function(String)? onItemSelected;
//
//   const DropDownButton({
//     super.key,
//     required this.hintText,
//     required this.menuItems,
//     this.offset = 1,
//     this.icon = Icons.add,
//     this.onItemSelected,
//   });
//
//   @override
//   State<DropDownButton> createState() => _DropDownButtonState();
// }
//
// class _DropDownButtonState extends State<DropDownButton> {
//   late String _selectedItem;
//   late ScrollController _scrollController;
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       onSelected: (value) {
//         widget.onItemSelected?.call(value);
//         setState(() {
//           _selectedItem = value;
//         });
//       },
//       itemBuilder: (context) {
//         return [
//           PopupMenuItem<String>(
//             child: SizedBox(
//               width: 120,
//               height: 250,
//               child: Scrollbar(
//                 controller: _scrollController,
//                 thumbVisibility: true,
//                 scrollbarOrientation: ScrollbarOrientation.left,
//                 child: SingleChildScrollView(
//                   controller: _scrollController,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: List.generate(widget.menuItems.length, (index) {
//                       final item = widget.menuItems[index];
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 4.0, horizontal: 8),
//                             child: Align(
//                               alignment: Alignment.centerLeft,
//                               child: Text(
//                                 item,
//                                 style: Theme.of(context)
//                                     .appTexts
//                                     .bodyMedium
//                                     .copyWith(
//                                   color: Theme.of(context)
//                                       .appColors
//                                       .black60,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           if (index != widget.menuItems.length - 1)
//                             Divider(
//                               color: Theme.of(context).appColors.secondary,
//                               endIndent: 8,
//                               indent: 8,
//                             ),
//                         ],
//                       );
//                     }),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ];
//       },
//       offset: Offset(widget.offset + 40, 28),
//       tooltip: "",
//       color: Theme.of(context).appColors.background,
//       splashRadius: 0,
//       elevation: 0,
//       constraints: const BoxConstraints(
//         maxWidth: 120,
//         maxHeight: 250,
//       ),
//       shape: RoundedRectangleBorder(
//         side: BorderSide(
//           color: Theme.of(context).appColors.black16,
//           width: 0.5,
//         ),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.zero,
//           topRight: Radius.circular(16),
//           bottomLeft: Radius.circular(16),
//           bottomRight: Radius.circular(16),
//         ),
//       ),
//       child: Container(
//         clipBehavior: Clip.hardEdge,
//         margin: const EdgeInsets.symmetric(horizontal: 16),
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(50),
//           border:
//           Border.all(color: Theme.of(context).appColors.primary, width: 0.5),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               widget.icon,
//               color: Theme.of(context).appColors.primary,
//               size: 16,
//             ),
//             const SizedBox(width: 8),
//             Text(
//               widget.hintText,
//               style: Theme.of(context).appTexts.bodySmall.copyWith(
//                 color: Theme.of(context).appColors.primary,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class DropDownButton extends StatefulWidget {
  final String hintText;
  final double offset;
  final IconData icon;
  final List<String> menuItems;
  final Function(String)? onItemSelected;

  const DropDownButton({
    super.key,
    required this.hintText,
    required this.menuItems,
    this.offset = 1,
    this.icon = Icons.add,
    this.onItemSelected,
  });

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  late String _selectedItem;

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
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      item,
                      style: Theme.of(context).appTexts.bodyMedium.copyWith(
                        color: Theme.of(context).appColors.black60,
                      ),
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
      offset: Offset(widget.offset + 40, 28),
      tooltip: "",
      color: Theme.of(context).appColors.background,
      splashRadius: 0,
      elevation: 0,
      constraints: const BoxConstraints(
        maxWidth: 120,
        maxHeight: 250,
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
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border:
          Border.all(color: Theme.of(context).appColors.primary, width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: Theme.of(context).appColors.primary,
              size: 16,
            ),
            const SizedBox(width: 8),
            Text(
              widget.hintText,
              style: Theme.of(context).appTexts.bodySmall.copyWith(
                color: Theme.of(context).appColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

}