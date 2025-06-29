import 'package:planitly/features/home_screen/domain/entity/custom_template_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class CustomTemplateDto extends BaseMapper<CustomTemplateDto> {
  String? id;
  String? name;
  String? type;
  String? category;
  String? description;
  DateTime? createdAt;

  CustomTemplateDto({
     this.id,
     this.name,
     this.type,
     this.category,
     this.description,
      this.createdAt,
  });

  @override
  CustomTemplateDto fromJson(Map<String, dynamic> json) {
    return CustomTemplateDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      category: json['category'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson(CustomTemplateDto object) {
    return {
      'id': object.id,
      'name': object.name,
      'type': object.type,
      'category': object.category,
      'description': object.description,
      'createdAt': object.createdAt?.toIso8601String(),
    };
  }

  CustomTemplateEntity toEntity() {
    return CustomTemplateEntity(
      id: id ?? '',
      name: name ?? '',
      type: type ?? '',
      category: category ?? '',
      description: description ?? '',
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}