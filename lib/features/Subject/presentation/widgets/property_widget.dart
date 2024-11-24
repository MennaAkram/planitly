import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Subject/presentation/widgets/property.dart';

import 'list_text_field.dart';

class PropertyWidget extends StatefulWidget {
  final String propertyName;
  final List<Property> selectedProperties;
  final Function(Property) onPropertyUpdated;

  const PropertyWidget({
    super.key,
    required this.propertyName,
    required this.selectedProperties,
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
    final property = widget.selectedProperties.firstWhere(
      (property) => property.name == widget.propertyName,
      orElse: () {
        final newProperty = Property(
          name: widget.propertyName,
          value: "",
          type: PropertyType.string,
        );
        widget.selectedProperties.add(newProperty);
        return newProperty;
      },
    );
    _controller.text = property.value.toString();
  }

  void _updateProperty(PropertyType type, dynamic value) {
    setState(() {
      final property = widget.selectedProperties
          .firstWhere(
            (property) => property.name == widget.propertyName,
          )
          .copyWith(type: type, value: value);

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
          widget.propertyName,
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
    switch (widget.propertyName) {
      case 'List' || 'Charts Data':
        return ListTextField(
            keyboardType: widget.propertyName == PropertyType.list.name
                ? TextInputType.text
                : TextInputType.number,
            onSubmitted: (chips) {
              log("Chips: $chips");
              log("Chips.toInts(): ${chips.toInts()}");

              _updateProperty(
                widget.propertyName == PropertyType.list.name
                    ? PropertyType.list
                    : PropertyType.intList,
                widget.propertyName == PropertyType.list.name
                    ? chips
                    : chips.toInts(),
              );
            });
      default:
        return TextField(
          controller: _controller,
          textAlignVertical: TextAlignVertical.center,
          keyboardType: widget.propertyName == PropertyType.string.name
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
  List<int> toInts() {
    return map((e) => int.tryParse(e) ?? 0).toList();
  }
}
