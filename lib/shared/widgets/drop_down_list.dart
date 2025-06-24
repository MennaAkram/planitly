import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/shared/assets.dart';

class DropDownList extends StatefulWidget {
  final String hintText;
  final String icon;
  final List<String> menuItems;
  final Function(String)? onItemSelected;
  final ScrollController? scrollController;
  final VoidCallback? onScrollEnd;
  final bool isLoading;

  const DropDownList({
    super.key,
    required this.hintText,
    required this.menuItems,
    this.onItemSelected,
    this.icon = Assets.chevronDown,
    this.scrollController,
    this.onScrollEnd,
    this.isLoading = false,
  });

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList>
    with SingleTickerProviderStateMixin {
  final LayerLink _layerLink = LayerLink();
  late final ScrollController _scrollController;
  late final AnimationController _ctrl;
  late final Animation<double> _anim;
  late String _selectedItem;
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.hintText;
    _scrollController = widget.scrollController ?? ScrollController();
    _scrollController.addListener(_onScroll);
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
  }

  @override
  void didUpdateWidget(covariant DropDownList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_isOpen &&
        (oldWidget.menuItems != widget.menuItems ||
            oldWidget.isLoading != widget.isLoading)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _overlayEntry?.markNeedsBuild();
      });
    }
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _scrollController.dispose();
    }
    _ctrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.7 &&
        !widget.isLoading) {
      widget.onScrollEnd?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleDropdown,
      borderRadius: BorderRadius.circular(50),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: _buildDropdownButton(context),
      ),
    );
  }

  Container _buildDropdownButton(BuildContext context) {
    return Container(
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
          SvgPicture.asset(
            widget.icon,
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }

  void _toggleDropdown() {
    if (_isOpen) {
      _ctrl.reverse().then((_) {
        _overlayEntry?.remove();
        _isOpen = false;
      });
    } else {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
      _isOpen = true;
      _ctrl.forward();
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    double maxTextWidth = 0;
    for (var item in widget.menuItems) {
      textPainter.text = TextSpan(
        text: item,
        style: Theme.of(context).appTexts.bodyMedium,
      );
      textPainter.layout();
      maxTextWidth =
          maxTextWidth < textPainter.width ? textPainter.width : maxTextWidth;
    }

    final double overlayWidth = (maxTextWidth + 8 + 32).clamp(0, 100.0);

    final int itemCount = widget.menuItems.length;
    const int maxVisibleItems = 4;
    const double itemHeight = 60;
    final double dropdownHeight =
        (itemCount <= maxVisibleItems ? itemCount : maxVisibleItems) *
            itemHeight;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleDropdown,
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 8,
            width: overlayWidth,
            child: CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(size.width - overlayWidth, 28),
              child: _buildDropdownOverlay(context, dropdownHeight, itemCount),
            ),
          )
        ],
      ),
    );
  }

  Material _buildDropdownOverlay(
      BuildContext context, double height, int itemCount) {
    return Material(
      color: Colors.transparent,
      child: SizeTransition(
        sizeFactor: _anim,
        axisAlignment: -1.0,
        child: Material(
          color: Theme.of(context).appColors.background,
          elevation: 0,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            side: BorderSide(
              color: Theme.of(context).appColors.black16,
              width: 0.5,
            ),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: height,
              maxWidth: 100,
            ),
            child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 8),
                itemCount: widget.menuItems.length + (widget.isLoading ? 1 : 0),
                itemBuilder: (ctx, i) {
                  if (i < widget.menuItems.length) {
                    return _buildMenuItem(context, widget.menuItems[i]);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }

  Padding _buildMenuItem(BuildContext context, String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          widget.onItemSelected?.call(item);
          setState(() {
            _selectedItem = item;
          });
          _toggleDropdown();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).appTexts.bodyMedium.copyWith(
                      color: Theme.of(context).appColors.black60,
                    ),
              ),
              Divider(
                color: Theme.of(context).appColors.secondary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
