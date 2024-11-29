import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Subject/presentation/widgets/table_widget.dart';
import 'package:planitly/features/Subject/presentation/widgets/property_widget.dart';
import 'package:planitly/features/Subject/presentation/widgets/upload_photo_button.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import '../../../../shared/widgets/button.dart';
import '../widgets/drop_down_menu.dart';
import 'package:planitly/features/Subject/presentation/widgets/property.dart';
import '../widgets/pie_chart.dart';
import 'package:collection/collection.dart';

class WidgetPropertyLink {
  final String widgetId;
  final String? propertyId;
  XFile? image;

  WidgetPropertyLink({required this.widgetId, this.propertyId, this.image});
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
  List<Property> selectedProperties = [];
  List<WidgetPropertyLink> selectedWidgets = [];
  final List<String> propertiesData = [
    PropertyType.string.name,
    PropertyType.number.name,
    PropertyType.boolean.name,
    PropertyType.list.name,
    PropertyType.intList.name,
    PropertyType.phone.name
  ];
  final List<Map<String, dynamic>> tableData = [
    {"Name": "John", "Age": 25, "City": "New York"},
    {"Name": "Sarah", "Age": 30, "City": "London"},
  ];
  final List<Property> properties = [];
  String? selectedProperty;

  final List<WidgetDefinition> widgets = [
    WidgetDefinition(
        name: WidgetType.pieChart.name, requiredTypes: [List, num]),
    WidgetDefinition(name: WidgetType.donutChart.name, requiredTypes: [List]),
    WidgetDefinition(name: WidgetType.todoList.name, requiredTypes: [String]),
    WidgetDefinition(name: WidgetType.picture.name, requiredTypes: [XFile]),
    WidgetDefinition(name: WidgetType.calender.name, requiredTypes: [String]),
    WidgetDefinition(name: WidgetType.toContacts.name, requiredTypes: [num]),
    WidgetDefinition(name: WidgetType.table.name, requiredTypes: [Map])
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _dismissOverlays();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).appColors.background,
        appBar: const CustomAppBar(title: "Subject Name"),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selectedProperties.isNotEmpty) _buildPropertiesSection(),
              if (selectedProperties.isNotEmpty) const SizedBox(height: 16),
              _buildAddPropertyButton(),
              const SizedBox(height: 24),
              Divider(
                  height: 1,
                  color: Theme.of(context).appColors.secondary,
                  indent: 16,
                  endIndent: 16),
              const SizedBox(height: 24),
              _buildAddWidgetButton(),
              const SizedBox(height: 24),
              _buildWidgetsSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, LayerLink layerLink,
      Function onPressed,
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
              final uniquePropertyName = _generateUniquePropertyName(property);
              selectedProperties.add(uniquePropertyName);
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

  Property _generateUniquePropertyName(String baseName) {
    final type =
        PropertyType.values.where((type) => type.name == baseName).first;
    final selectedNames = selectedProperties
        .where((property) => property.name.startsWith(baseName))
        .map((property) => property.name)
        .toList();
    final uniqueName =
        selectedNames.isEmpty ? baseName : "$baseName ${selectedNames.length}";
    return Property.withoutId(name: uniqueName, value: "", type: type);
  }

  Future<XFile?> pickImage() async {
    _dismissOverlays();
    ImagePicker imagePicker = ImagePicker();
    try {
      final photo = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 1000,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (photo != null) {
        File file = File(photo.path);
        var fileSizeInMB = file.lengthSync() / (1024 * 1024);
        var extension = photo.path.split('.').last;

        if (fileSizeInMB > 2) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Image size should not exceed 2MB")),
            );
          }
          return null;
        }

        if (!(extension == 'jpg' ||
            extension == 'jpeg' ||
            extension == 'png')) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Only JPG, JPEG, or PNG images are supported")),
            );
          }
          return null;
        }

        log("Photo${photo.path}");
        return photo;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No image selected")),
        );
      }
      return null;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error picking image: $e")),
        );
      }
      return null;
    }
  }

  void _showPropertySelectionDialog(String widgetName) {
    final WidgetDefinition widgetDefinition = widgets.firstWhere(
          (widget) => widget.name == widgetName,
      orElse: () => WidgetDefinition(name: "Default", requiredTypes: []),
    );

    if (widgetName == WidgetType.table.name) {
      setState(() {
        selectedWidgets.add(WidgetPropertyLink(
          widgetId: widgetDefinition.id,
          propertyId: null, // No property linking required for table
        ));
      });
      return; // Exit the function to prevent dialog from opening
    }

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
        if ((widgetName != WidgetType.calender.name)) {
          return AlertDialog(
            backgroundColor: Theme.of(context).appColors.background,
            title: Text(
              widgetName == WidgetType.picture.name
                  ? "Upload Photo"
                  : "Select Property for $widgetName",
              style: Theme.of(context).appTexts.titleMedium.copyWith(
                    color: Theme.of(context).appColors.black87,
                  ),
            ),
            content: widgetName == WidgetType.picture.name
                ? UploadPhotoButton(
                    onPressed: () async {
                      XFile? selectedImage = await pickImage();
                      if (selectedImage != null) {
                        setState(() {
                          selectedWidgets.add(WidgetPropertyLink(
                            widgetId: widgetDefinition.id,
                            image: selectedImage,
                          ));
                          Navigator.of(context).pop();
                        });
                      }
                    },
                    image: null,
                    text: "Select picture from gallery",
                  )
                : intListProperties.isEmpty
                    ? Text(
                        "No matching properties available.",
                        style: Theme.of(context).appTexts.bodyMedium.copyWith(
                            color: Theme.of(context).appColors.black60),
                      )
                    : _buildButton(
                        context,
                        "Select property",
                        _dialogLayerLink,
                        () {
                          _toggleDropdownMenu(
                            _dialogLayerLink,
                            _dialogOverlayEntry,
                            intListProperties
                                .map((property) => property.name)
                                .toList(),
                          );
                        },
                        icon: Icons.arrow_drop_down,
                      ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: Theme.of(context)
                      .appTexts
                      .bodySmall
                      .copyWith(color: Theme.of(context).appColors.primary),
                ),
              ),
              TextButton(
                onPressed: () {
                  final selected = intListProperties.firstWhereOrNull(
                      (property) => property.name == selectedProperty);

                  if (selected != null) {
                    setState(() {
                      selectedWidgets.add(WidgetPropertyLink(
                        widgetId: widgetDefinition.id,
                        propertyId: selected.id,
                      ));
                    });
                  }
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Confirm",
                  style: Theme.of(context)
                      .appTexts
                      .bodySmall
                      .copyWith(color: Theme.of(context).appColors.primary),
                ),
              ),
            ],
          );
        } else {
          return _buildCalenderWidget();
        }
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

  void _dismissOverlays() {
    _propertyOverlayEntry?.remove();
    _widgetOverlayEntry?.remove();
    _dialogOverlayEntry?.remove();
    _propertyOverlayEntry = null;
    _widgetOverlayEntry = null;
    _dialogOverlayEntry = null;
  }

  Widget _buildPropertiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              selectedProperty: propertyName,
              onPropertyUpdated: (updatedProperty) {
                _updateProperty(updatedProperty);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  void _updateProperty(updatedProperty) {
    setState(() {
      final index =
          properties.indexWhere((p) => p.name == updatedProperty.name);
      if (index != -1) {
        properties[index] = updatedProperty;
      } else {
        properties.add(updatedProperty);
      }
    });
  }

  Widget _buildAddPropertyButton() {
    return _buildButton(
      context,
      'Add Property',
      _propertyLayerLink,
      () => _toggleDropdownMenu(
        _propertyLayerLink,
        _propertyOverlayEntry,
        propertiesData,
      ),
    );
  }

  Widget _buildAddWidgetButton() {
    return _buildButton(
      context,
      'Add Widget',
      _widgetLayerLink,
      () => _toggleDropdownMenu(
        _widgetLayerLink,
        _widgetOverlayEntry,
        widgets.map((widget) => widget.name).toList(),
      ),
    );
  }

  Widget _buildWidgetsSection() {
    return Column(
      children: selectedWidgets.map((widgetLink) {
        Property? linkedProperty = properties.firstWhereOrNull(
            (property) => property.id == widgetLink.propertyId);
        WidgetDefinition? linkedWidget = widgets
            .firstWhereOrNull((widget) => widget.id == widgetLink.widgetId);

        if (linkedWidget != null) {
          if (linkedWidget.name == WidgetType.table.name) {
            return _buildTableWidget(widgetLink);
          } else if (linkedWidget.name == WidgetType.picture.name) {
            if (widgetLink.image != null) {
              return _buildPictureWidget(widgetLink.image!.path, widgetLink);
            } else {
              return const Text("No image selected for Picture widget.");
            }
          } else if (linkedProperty != null &&
              linkedProperty.value is List<num>) {
            return _buildPieChartWidget(linkedProperty.value, widgetLink);
          } else if (linkedProperty != null && linkedProperty.value is String) {
            return const Text("Text widgets");
          } else if (linkedProperty != null && linkedProperty.value is bool) {
            return const Text("Checkbox widgets");
          } else if (linkedProperty != null && linkedProperty.value is List) {
            return const Text("To-Do List widgets");
          } else if (linkedProperty != null && linkedProperty.value is Map) {
            // return _buildCalenderWidget(widgetLink);
          } else if (linkedProperty != null && linkedProperty.value is int) {
            return const Text("Contacts widgets");
          }
        }
        return const Text("No valid data for the widget.");
      }).toList(),
    );
  }

  Widget _buildTableWidget(WidgetPropertyLink widgetLink) {
    return _buildWidgetsContainer(
      const CustomTable(),
      widgetLink,
    );
  }

  Widget _buildWidgetsContainer(Widget widget, WidgetPropertyLink widgetLink) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          widget,
          Positioned(
            top: 8,
            right: 24,
            child: IconButton(
              icon: Icon(
                Icons.remove_circle_outline_rounded,
                size: 24,
                color: Theme.of(context).appColors.primary,
              ),
              onPressed: () => setState(() {
                selectedWidgets.remove(widgetLink);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPictureWidget(String imagePath, WidgetPropertyLink widgetLink) {
    return _buildWidgetsContainer(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.file(
            File(imagePath),
            fit: BoxFit.cover,
            height: 250,
            width: double.infinity,
          ),
        ),
      ),
      widgetLink,
    );
  }

  Widget _buildPieChartWidget(List<num> data, WidgetPropertyLink widgetLink) {
    return _buildWidgetsContainer(
        PieChartSample(
          data: data,
          isPieChart: widgets
                  .firstWhere((widget) => widget.id == widgetLink.widgetId)
                  .name ==
              WidgetType.pieChart.name,
        ),
        widgetLink);
  }

  Widget _buildCalenderWidget() {
    return Material(
      child: Center(
        child: CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime(2021),
          lastDate: DateTime(2025),
          onDateChanged: (DateTime date) {
            print("Date: $date");
          },
        ),
      ),
    );
  }
}
