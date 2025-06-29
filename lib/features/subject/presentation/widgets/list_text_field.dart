import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';

class ListTextField extends StatefulWidget {
  const ListTextField({
    required this.onSubmitted,
    required this.keyboardType,
    this.initialValues = const [],
    super.key,
  });

  final List<String> initialValues;
  final void Function(List<String>) onSubmitted;
  final TextInputType keyboardType;

  @override
  State<ListTextField> createState() => _ListTextFieldState();
}

class _ListTextFieldState extends State<ListTextField> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _chips = [];

  @override
  void initState() {
    super.initState();
    _chips.addAll(widget.initialValues);
  }

  void _addChip(String chip) {
    if (chip.trim().isNotEmpty) {
      setState(() {
        _chips.add(chip.trim());
        _controller.clear();
      });
      widget.onSubmitted(_chips);
    }
  }

  void _removeChip(int index) {
    setState(() {
      _chips.removeAt(index);
    });
    widget.onSubmitted(_chips);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ..._buildChips(context),
        _buildTextField(context),
      ],
    );
  }

  List<Widget> _buildChips(BuildContext context) {
    return _chips.asMap().entries.map((entry) {
      final index = entry.key;
      final text = entry.value;
      return _buildChip(context, text, index);
    }).toList();
  }

  Widget _buildChip(BuildContext context, String text, int index) {
    return Container(
      margin: const EdgeInsets.only(left: 8, top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).appColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: Theme.of(context).appTexts.labelMedium.copyWith(
                  color: Theme.of(context).appColors.white100,
                ),
          ),
          GestureDetector(
            onTap: () => _removeChip(index),
            child: const Padding(
              padding: EdgeInsets.only(left: 4),
              child: Icon(Icons.close, size: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return TextField(
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(bottom: 15, left: 16),
        border: InputBorder.none,
        hintText: "Empty",
        hintStyle: Theme.of(context).appTexts.bodySmall.copyWith(
              color: Theme.of(context).appColors.black60,
            ),
      ),
      style: Theme.of(context).appTexts.bodySmall.copyWith(
            color: Theme.of(context).appColors.black87,
          ),
      keyboardType: widget.keyboardType,
      controller: _controller,
      onSubmitted: _addChip,
      onChanged: (value) {
        if (value.endsWith(' ')) {
          _addChip(value.trim());
        }
      },
    );
  }
}
