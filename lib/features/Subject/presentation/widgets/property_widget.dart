import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Subject/presentation/widgets/property.dart';

import 'list_text_field.dart';

class PropertyWidget extends StatefulWidget {
  final Property selectedProperty;
  final Function(Property) onPropertyUpdated;

  const PropertyWidget({
    super.key,
    required this.selectedProperty,
    required this.onPropertyUpdated,
  });

  @override
  State<PropertyWidget> createState() => _PropertyWidgetState();
}

class _PropertyWidgetState extends State<PropertyWidget> {
  final TextEditingController _controller = TextEditingController();
  String _inputValue = "";

  @override
  void initState() {
    super.initState();
    _initializeProperty();
  }

  void _initializeProperty() {
    _controller.text = widget.selectedProperty.value.toString();
  }

  void _updateProperty(PropertyType type, dynamic value) {
    setState(() {
      final property = widget.selectedProperty.copyWith(type: type, value: value);

      widget.onPropertyUpdated(property);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildPropertyName(context),
          _buildPropertyInput(context),
        ],
      ),
    );
  }

  Widget _buildPropertyName(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).appColors.secondary,
              width: 1,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          widget.selectedProperty.name,
          style: Theme.of(context).appTexts.bodySmall.copyWith(
                color: Theme.of(context).appColors.black87,
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildPropertyInput(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).appColors.secondary,
              width: 1,
            ),
            left: BorderSide(
              color: Theme.of(context).appColors.secondary,
              width: 1,
            ),
          ),
        ),
        child: _getInputField(),
      ),
    );
  }

  Widget _getInputField() {
    switch (widget.selectedProperty.type.name) {
      case 'List' || 'Charts Data':
        return ListTextField(
            keyboardType: widget.selectedProperty.type.name == PropertyType.list.name
                ? TextInputType.text
                : TextInputType.number,
            onSubmitted: (chips) {
              _updateProperty(
                widget.selectedProperty.type.name == PropertyType.list.name
                    ? PropertyType.list
                    : PropertyType.intList,
                widget.selectedProperty.type.name == PropertyType.list.name
                    ? chips
                    : chips.toDouble(),
              );
            });
      default:
        return TextField(
          controller: _controller,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: widget.selectedProperty.type.name == PropertyType.string.name
              ? TextInputType.text
              : TextInputType.number,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(bottom: 6, left: 16),
            hintText: "Empty",
            hintStyle: Theme.of(context).appTexts.bodySmall.copyWith(
                  color: Theme.of(context).appColors.black60,
                ),
          ),
          style: Theme.of(context).appTexts.bodySmall.copyWith(
                color: Theme.of(context).appColors.black87,
              ),
          onChanged: (value) {
            setState(() {
              _inputValue = value;
              _updateProperty(PropertyType.string, _inputValue);
            });
          },
        );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

extension ListExtensions on List<String> {
  List<double> toDouble() {
    return map((e) => double.tryParse(e) ?? 0.0).toList();
  }
}
