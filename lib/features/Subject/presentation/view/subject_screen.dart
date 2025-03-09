import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:planitly/design_system/theme.dart';
import 'package:planitly/features/Subject/presentation/widgets/calendar.dart';
import 'package:planitly/features/Subject/presentation/widgets/contact_card.dart';
import 'package:planitly/features/Subject/presentation/widgets/table_widget.dart';
import 'package:planitly/features/Subject/presentation/widgets/property_widget.dart';
import 'package:planitly/features/Subject/presentation/widgets/upload_photo_button.dart';
import 'package:planitly/shared/widgets/app_bar.dart';
import 'package:planitly/shared/widgets/drop_down_list.dart';
import 'package:planitly/shared/widgets/extensions.dart';
import '../../../../shared/widgets/button.dart';
import '../widgets/drop_down_menu.dart';
import 'package:planitly/features/Subject/presentation/widgets/property.dart';
import '../widgets/pie_chart.dart';
import 'package:collection/collection.dart';

import '../widgets/todo_list.dart';

class WidgetPropertyLink {
  final String widgetId;
  final List<String>? propertyIds;
  XFile? image;

  WidgetPropertyLink({required this.widgetId, this.propertyIds, this.image});
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
  final LayerLink _dialogLayerLink2 = LayerLink();
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
    PropertyType.phone.name,
    PropertyType.date.name,
  ];
  final List<Property> properties = [];
  List<String> selectedProperty = [];

  final List<WidgetDefinition> widgets = [
    WidgetDefinition(
        name: WidgetType.pieChart.name, requiredTypes: [List, num]),
    WidgetDefinition(name: WidgetType.donutChart.name, requiredTypes: [List]),
    WidgetDefinition(name: WidgetType.todoList.name, requiredTypes: [String]),
    WidgetDefinition(name: WidgetType.picture.name, requiredTypes: [XFile]),
    WidgetDefinition(name: WidgetType.calender.name, requiredTypes: [DateTime]),
    WidgetDefinition(name: WidgetType.contact.name, requiredTypes: [String]),
    WidgetDefinition(name: WidgetType.table.name, requiredTypes: [Map])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  Widget _buildButton(BuildContext context, String text, LayerLink layerLink,
      Function onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CompositedTransformTarget(
        link: layerLink,
        child: CustomButton(
          horizontalPadding: 12,
          verticalPadding: 8,
          text: text,
          onPressed: () => onPressed(),
          outlined: true,
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
      // if (_widgetOverlayEntry == null) {
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
      // } else {
      //   _widgetOverlayEntry?.remove();
      //   _widgetOverlayEntry = null;
      // }
    } else if (layerLink == _propertyLayerLink) {
      // if (_propertyOverlayEntry == null) {
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
      // }
      // else {
      //   // _propertyOverlayEntry?.remove();
      //   _propertyOverlayEntry = null;
      // }
    } else if (layerLink == _dialogLayerLink) {
      // if (_dialogOverlayEntry == null) {
      final newOverlayEntry = DropDownMenu.createOverlayEntry(
        context,
        layerLink,
        data,
        (String property) {
          setState(() {
            selectedProperty.add(property);
          });
          _dialogOverlayEntry?.remove();
          _dialogOverlayEntry = null;
        },
      );
      Overlay.of(context).insert(newOverlayEntry);
      _dialogOverlayEntry = newOverlayEntry;
      // } else {
      //   _dialogOverlayEntry?.remove();
      //   _dialogOverlayEntry = null;
      // }
    } else if (layerLink == _dialogLayerLink2) {
      // if (_dialogOverlayEntry == null) {
      final newOverlayEntry = DropDownMenu.createOverlayEntry(
        context,
        layerLink,
        data,
        (String property) {
          setState(() {
            selectedProperty.add(property);
          });
          _dialogOverlayEntry?.remove();
          _dialogOverlayEntry = null;
        },
      );
      Overlay.of(context).insert(newOverlayEntry);
      _dialogOverlayEntry = newOverlayEntry;
      // } else {
      //   _dialogOverlayEntry?.remove();
      //   _dialogOverlayEntry = null;
      // }
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

    if (widgetName == WidgetType.table.name ||
        widgetName == WidgetType.todoList.name) {
      setState(() {
        selectedWidgets.add(WidgetPropertyLink(
          widgetId: widgetDefinition.id,
          propertyIds: [],
        ));
      });
      return;
    }

    List<Property> intListProperties = properties.where((property) {
      final value = property.value;
      if (widgetDefinition.requiredTypes.contains(List) && value is List) {
        return value.every((element) => element is num);
      }
      return widgetDefinition.requiredTypes.contains(value.runtimeType);
    }).toList();

    List<String> contactsProperties = properties.where((property) {
      if (widgetDefinition.name == WidgetType.contact.name && property.name.contains("Phone")) {
        return true;
      }
      return false;
    }).map((property) => property.name).toList();

    List<DateTime> dateProperties = properties
        .where((property) {
          final value = property.value;
          if (widgetDefinition.name == WidgetType.calender.name &&
              value is DateTime) {
            return true;
          }
          return false;
        })
        .map((property) => property.value as DateTime)
        .toList();

    context.alertDialog(
      widgetName == WidgetType.picture.name
          ? "Upload Photo"
          : "Select Property for $widgetName",
      "Confirm",
      "Cancel",
      () {
        final selected = intListProperties
            .firstWhereOrNull((property) => selectedProperty.contains(property.name));

        if (selectedProperty.isNotEmpty) {
          setState(() {
            selectedWidgets.add(WidgetPropertyLink(
              widgetId: widgetDefinition.id,
              propertyIds: selectedProperty,
            ));
          });
        }
        Navigator.of(context).pop();
      },
      () {
        Navigator.of(context).pop();
      },
      widgetName == WidgetType.picture.name
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
                  style: Theme.of(context)
                      .appTexts
                      .bodyMedium
                      .copyWith(color: Theme.of(context).appColors.black60),
                )
              : widgetName == WidgetType.calender.name
                  ?  const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                    //     DropDownList(
                    //       hintText: 'Select Start Date',
                    //       layerLink: _dialogLayerLink,
                    //       onPressed: () => _toggleDropdownMenu(
                    //         _dialogLayerLink,
                    //         _dialogOverlayEntry,
                    //         dateProperties.map((property) => property.format() ?? '')
                    //             .toList(),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 16),
                    //     DropDownList(
                    //       hintText: 'Select End Date',
                    //       layerLink: _dialogLayerLink2,
                    //       onPressed: () => _toggleDropdownMenu(
                    //         _dialogLayerLink2,
                    //         _dialogOverlayEntry,
                    //         dateProperties.map((property) => property.format() ?? '')
                    //             .toList(),
                    //       ),
                    //     ),
                      ],
                    ): const SizedBox(),
                  // : DropDownList(
                  //     hintText: 'Select Property',
                  //     layerLink: _dialogLayerLink,
                  //     onPressed: () => _toggleDropdownMenu(
                  //       _dialogLayerLink,
                  //       _dialogOverlayEntry,
                  //       contactsProperties.isNotEmpty
                  //           ? contactsProperties
                  //           : intListProperties
                  //               .map((property) => property.name)
                  //               .toList(),
                  //     ),
                  //   ),
    );
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
        List<Property> linkedProperties = properties.where((property) {
          final propertyIds = widgetLink.propertyIds ?? [];
          return propertyIds.contains(property.name);
        }).toList();
        WidgetDefinition? linkedWidget = widgets
            .firstWhereOrNull((widget) => widget.id == widgetLink.widgetId);

        final WidgetDefinition widgetDefinition = widgets.firstWhere(
              (widget) => widget.name == linkedWidget?.name,
          orElse: () => WidgetDefinition(name: "Default", requiredTypes: []),
        );

        List<Property> intListProperties = properties.where((property) {
          final value = property.value;
          if (widgetDefinition.requiredTypes.contains(List) && value is List) {
            return value.every((element) => element is num);
          }
          return widgetDefinition.requiredTypes.contains(value.runtimeType);
        }).toList();

        List contactsProperties = properties.where((property) {
          final value = property.value;
          if (widgetDefinition.name == WidgetType.contact.name && value is String) {
            return true;
          }
          return false;
        }).map((property) => property.value).toList();

        List<DateTime> dateProperties = properties
            .where((property) {
          final value = property.value;
          if (widgetDefinition.name == WidgetType.calender.name &&
              value is DateTime) {
            return true;
          }
          return false;
        })
            .map((property) => property.value as DateTime)
            .toList();
        log("Linked properties: ${linkedProperties.map((p) => p.value).toList()}");
        log("Int properties: ${intListProperties.map((p) => p.value).toList()}");
        log("Date properties: ${dateProperties.map((p) => p).toList()}");
        log("contact properties: ${contactsProperties.map((p) => p).toList()}");
        log("Selected properties: ${selectedProperties.map((p) => p.name).toList()}");
        log("widgetLink.propertyIds: ${widgetLink.propertyIds}");
        log("Properties: ${properties.map((p) => "id: ${p.id}, name: ${p.name}, value: ${p.value}")}");

        if (linkedWidget != null) {
          log("Widget name: ${linkedWidget.name}, Linked properties: ${linkedProperties.map((p) => p.value).toList()}");

          if (linkedWidget.name == WidgetType.table.name) {
            return _buildTableWidget(widgetLink);
          } else if (linkedWidget.name == WidgetType.todoList.name) {
            return _buildTodoListWidget(widgetLink);
          } else if (linkedWidget.name == WidgetType.picture.name) {
            if (widgetLink.image != null) {
              return _buildPictureWidget(widgetLink.image!.path, widgetLink);
            } else {
              return const Text("No image selected for Picture widget.");
            }
          } else if (intListProperties.isNotEmpty &&
              intListProperties.every((item) => item.value is List<num>)) {
            return _buildPieChartWidget(intListProperties.first.value, widgetLink);
          } else if (dateProperties.isNotEmpty &&
              dateProperties.every((item) => item is DateTime)) {
            final startDate = dateProperties.first;
            final endDate = dateProperties.last;
            return _buildCalenderWidget(startDate, endDate, widgetLink);
          } else if (contactsProperties.isNotEmpty &&
              contactsProperties.every((item) => item is String)) {
            final contacts = contactsProperties.first;
            return _buildContactWidget(contacts, widgetLink);
          }
        }

        log(linkedProperties.firstOrNull?.value.toString() ??'');
        log(linkedProperties.lastOrNull?.value.toString() ??'');
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

  Widget _buildTodoListWidget(WidgetPropertyLink widgetLink) {
    return _buildWidgetsContainer(
      const ToDoListScreen(),
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
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
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

  Widget _buildContactWidget(String data, WidgetPropertyLink widgetLink) {
    return _buildWidgetsContainer(
        ContactCard(
          phoneNumber: data,
        ),
        widgetLink);
  }

  Widget _buildCalenderWidget(
      DateTime startDate, DateTime endDate, WidgetPropertyLink widgetLink) {
    log("Start date: $startDate, End date: $endDate");
    return _buildWidgetsContainer(
        Calendar(
          startDate: startDate,
          endDate: endDate,
        ),
        widgetLink);
  }
}
