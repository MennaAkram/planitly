import 'package:planitly/features/home_screen/domain/entity/component_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class ComponentsDto extends BaseMapper<ComponentsDto> {
  String? name;
  String? id;
  Map<String, dynamic>? data;
  String? compType;
  String? hostSubject;
  String? owner;
  bool? isDeletable;
  List<String>? referencedByWidgets;
  String? allowedWidgetType;

  ComponentsDto({
    this.name,
    this.id,
    this.data,
    this.compType,
    this.hostSubject,
    this.owner,
    this.isDeletable,
    this.referencedByWidgets,
    this.allowedWidgetType,
  });

  @override
  Map<String, dynamic> toJson(ComponentsDto object) {
    return {
      'name': object.name,
      'id': object.id,
      'data': object.data,
      'comp_type': object.compType,
      'host_subject': object.hostSubject,
      'owner': object.owner,
      'is_deletable': object.isDeletable,
      'referenced_by_widgets': object.referencedByWidgets,
      'allowed_widget_type': object.allowedWidgetType,
    };
  }

  @override
  ComponentsDto fromJson(Map<String, dynamic> json) {
    return ComponentsDto(
      name: json['name'] as String?,
      id: json['id'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      compType: json['comp_type'] as String?,
      hostSubject: json['host_subject'] as String?,
      owner: json['owner'] as String?,
      isDeletable: json['is_deletable'] as bool?,
      referencedByWidgets: (json['referenced_by_widgets'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      allowedWidgetType: json['allowed_widget_type'] as String?,
    );
  }

  ComponentsEntity toEntity() {
    return ComponentsEntity(
      name: name ?? '',
      id: id ?? '',
      data: data ?? {},
      compType: compType ?? '',
      hostSubject: hostSubject ?? '',
      owner: owner ?? '',
      isDeletable: isDeletable ?? false,
      referencedByWidgets: referencedByWidgets ?? [],
      allowedWidgetType: allowedWidgetType ?? '',
    );
  }
}
