import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Subject/presentation/widgets/property_widget.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import '../../../../shared/widgets/button.dart';
import '../widgets/drop_down_menu.dart';
import 'package:planitly/features/Subject/presentation/widgets/property.dart';
import '../widgets/pie_chart.dart';
import 'package:collection/collection.dart';

class WidgetPropertyLink {
  final String widgetName;
  final String propertyName;

  WidgetPropertyLink({required this.widgetName, required this.propertyName});
}

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  final LayerLink _propertyLayerLink = LayerLink();
  final LayerLink _widgetLayerLink = LayerLink();
  final LayerLink _dialogLayerLink = LayerLink();
  OverlayEntry? _propertyOverlayEntry;
  OverlayEntry? _widgetOverlayEntry;
  OverlayEntry? _dialogOverlayEntry;
  List<String> selectedProperties = [];
  List<WidgetPropertyLink> selectedWidgets = [];
  final List<String> propertiesData = [
    PropertyType.string.name,
    PropertyType.number.name,
    PropertyType.boolean.name,
    PropertyType.list.name,
    PropertyType.intList.name,
  ];
  final List<Map<String, dynamic>> tableData = [
    {"Name": "John", "Age": 25, "City": "New York"},
    {"Name": "Sarah", "Age": 30, "City": "London"},
  ];
  final List<Property> properties = [];
  String? selectedProperty;

  final List<WidgetDefinition> widgets = [
    WidgetDefinition(name: WidgetType.pieChart.name, requiredTypes: [List, num]),
    WidgetDefinition(name: WidgetType.donutChart.name, requiredTypes: [List]),
    WidgetDefinition(name: WidgetType.todoList.name, requiredTypes: [String]),
    WidgetDefinition(name: WidgetType.textField.name, requiredTypes: [String]),
    WidgetDefinition(name: WidgetType.picture.name, requiredTypes: [String]),
    WidgetDefinition(name: WidgetType.checkBox.name, requiredTypes: [String]),
    WidgetDefinition(name: WidgetType.calender.name, requiredTypes: [String]),
    WidgetDefinition(name: WidgetType.toContacts.name, requiredTypes: [String]),
    WidgetDefinition(name: WidgetType.numberLink.name, requiredTypes: [num]),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _propertyOverlayEntry?.remove();
        _propertyOverlayEntry = null;
        _widgetOverlayEntry?.remove();
        _widgetOverlayEntry = null;
        _dialogOverlayEntry?.remove();
        _dialogOverlayEntry = null;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).appColors.background,
        appBar: const CustomAppBar(title: "Subject Name"),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selectedProperties.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "Properties",
                    style: Theme.of(context).appTexts.bodySmall.copyWith(
                          color: Theme.of(context).appColors.black60,
                        ),
                  ),
                ),
              Column(
                children: selectedProperties.map((propertyName) {
                  return PropertyWidget(
                    propertyName: propertyName,
                    selectedProperties: properties,
                    onPropertyUpdated: (updatedProperty) {
                      setState(() {
                        final index = properties
                            .indexWhere((p) => p.name == updatedProperty.name);
                        if (index != -1) {
                          properties[index] = updatedProperty;
                        } else {
                          properties.add(updatedProperty);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              if (selectedProperties.isNotEmpty) const SizedBox(height: 16),
              _buildButton(
                context, 'Add Property', _propertyLayerLink,
                () => _toggleDropdownMenu(
                    _propertyLayerLink, _propertyOverlayEntry, propertiesData)
              ),
              const SizedBox(height: 24),
              Divider(
                height: 1,
                color: Theme.of(context).appColors.secondary,
                indent: 16,
                endIndent: 16,
              ),
              const SizedBox(height: 24),
              _buildButton(
                context, 'Add Widget', _widgetLayerLink,
                () => _toggleDropdownMenu(
                  _widgetLayerLink,
                  _widgetOverlayEntry,
                  widgets.map((widget) => widget.name).toList(),
                ),
              ),
              const SizedBox(height: 24),
              Column(
                children: selectedWidgets.map((widget) {
                  Property? linkedProperty = properties.firstWhereOrNull(
                          (property) => property.name == widget.propertyName);
                  if (linkedProperty != null) {
                    if (linkedProperty.value is List<int>) {
                      log("Pie Chart Data: ${linkedProperty.value}");
                      return Column(
                        children: [
                          ListTile(
                            title: Text(widget.widgetName),
                            subtitle: Text('Linked Property: ${widget.propertyName}'),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_circle_outline_rounded,
                                  size: 24, color: Theme.of(context).appColors.primary),
                              onPressed: () {
                                setState(() {
                                  selectedWidgets.remove(widget);
                                });
                              },
                            ),
                          ),

                          PieChartSample(
                            data: linkedProperty.value as List<int>,
                            isPieChart: widget.widgetName == "Pie Chart",
                          ),
                        ],
                      );
                    } else {
                      log("Invalid data type for Pie Chart: ${linkedProperty.value.runtimeType}");
                      return const Text("No valid data for Pie Chart");
                    }
                  } else {
                    return const Text("No valid data for Pie Chart");
                  }
                }).toList(),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
  BuildContext context, String text, LayerLink layerLink, Function onPressed,
      {IconData icon = Icons.add}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CompositedTransformTarget(
        link: layerLink,
        child: CustomButton(
          text: text,
          onPressed: () => onPressed(),
          outlined: true,
          icon: icon,
          addIcon: true,
        ),
      ),
    );
  }

  void _toggleDropdownMenu(
    LayerLink layerLink,
    OverlayEntry? overlayEntry,
    List<String> data,
  ) {
    if (layerLink == _widgetLayerLink) {
      if (_widgetOverlayEntry == null) {
        final newOverlayEntry = DropDownMenu.createOverlayEntry(
          context,
          layerLink,
          data,
          (String widgetName) {
            _showPropertySelectionDialog(widgetName);
            _widgetOverlayEntry?.remove();
            _widgetOverlayEntry = null;
          },
        );
        Overlay.of(context).insert(newOverlayEntry);
        _widgetOverlayEntry = newOverlayEntry;
      } else {
        _widgetOverlayEntry?.remove();
        _widgetOverlayEntry = null;
      }
    } else if (layerLink == _propertyLayerLink) {
      if (_propertyOverlayEntry == null) {
        final newOverlayEntry = DropDownMenu.createOverlayEntry(
          context,
          layerLink,
          data,
          (String property) {
            setState(() {
              selectedProperties.add(property);
            });
            _propertyOverlayEntry?.remove();
            _propertyOverlayEntry = null;
          },
        );
        Overlay.of(context).insert(newOverlayEntry);
        _propertyOverlayEntry = newOverlayEntry;
      } else {
        _propertyOverlayEntry?.remove();
        _propertyOverlayEntry = null;
      }
    } else if (layerLink == _dialogLayerLink) {
      if (_dialogOverlayEntry == null) {
        final newOverlayEntry = DropDownMenu.createOverlayEntry(
          context,
          layerLink,
          data,
          (String property) {
            setState(() {
              selectedProperty = property;
            });
            _dialogOverlayEntry?.remove();
            _dialogOverlayEntry = null;
          },
        );
        Overlay.of(context).insert(newOverlayEntry);
        _dialogOverlayEntry = newOverlayEntry;
      } else {
        _dialogOverlayEntry?.remove();
        _dialogOverlayEntry = null;
      }
    }
  }

  void _showPropertySelectionDialog(String widgetName) {
    final WidgetDefinition widgetDefinition = widgets.firstWhere(
          (widget) => widget.name == widgetName,
      orElse: () => WidgetDefinition(name: "Default", requiredTypes: []),
    );

    List<Property> intListProperties = properties.where((property) {
      final value = property.value;
      if (widgetDefinition.requiredTypes.contains(List) && value is List) {
        return value.every((element) => element is num);
      }
      return widgetDefinition.requiredTypes.contains(value.runtimeType);
    }).toList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).appColors.background,
          title: Text("Select Property for $widgetName",
              style: Theme.of(context)
                  .appTexts
                  .titleMedium
                  .copyWith(color: Theme.of(context).appColors.black87)),
          content: intListProperties.isEmpty
              ? Text("No matching properties available.",
              style: Theme.of(context)
                  .appTexts
                  .bodyMedium
                  .copyWith(color: Theme.of(context).appColors.black60))
              : _buildButton(
            context, "Select property", _dialogLayerLink,
            () {
              _toggleDropdownMenu(
                _dialogLayerLink,
                _dialogOverlayEntry,
                intListProperties.map((property) => property.name).toList(),
              );
            },
            icon: Icons.arrow_drop_down,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel",
                  style: Theme.of(context).appTexts.bodySmall.copyWith(
                      color: Theme.of(context).appColors.primary)),
            ),
            TextButton(
              onPressed: () {
                final selected = intListProperties.firstWhereOrNull(
                        (property) => property.name == selectedProperty);

                if (selected != null) {
                  setState(() {
                    selectedWidgets.add(WidgetPropertyLink(
                      widgetName: widgetName,
                      propertyName: selected.name,
                    ));
                  });
                }

                Navigator.of(context).pop();
              },
              child: Text("Confirm",
                  style: Theme.of(context).appTexts.bodySmall.copyWith(
                      color: Theme.of(context).appColors.primary)),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _propertyOverlayEntry?.remove();
    _widgetOverlayEntry?.remove();
    _dialogOverlayEntry?.remove();
    super.dispose();
  }
}