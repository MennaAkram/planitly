import 'package:planitly/features/home_screen/domain/entity/template_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class TemplateDto extends BaseMapper<TemplateDto> {
  String? name;
  String? type;
  String? category;
  String? description;

  TemplateDto({
     this.name,
     this.type,
     this.category,
     this.description,
  });

  @override
  TemplateDto fromJson(Map<String, dynamic> json) {
    return TemplateDto(
      name: json['name'] as String,
      type: json['type'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson(TemplateDto object) {
    return {
      'name': object.name,
      'type': object.type,
      'category': object.category,
      'description': object.description,
    };
  }

  TemplateEntity toEntity() {
    return TemplateEntity(
      name: name ?? '',
      type: type ?? '',
      category: category ?? '',
      description: description ?? '',
    );
  }
}