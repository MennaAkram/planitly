import 'package:planitly/features/home_screen/data/remote/template_dto.dart';
import 'package:planitly/features/home_screen/domain/entity/templates_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';
import 'custom_template_dto.dart';

class TemplatesDto extends BaseMapper<TemplatesDto> {
  List<TemplateDto>? predefined;
  List<CustomTemplateDto>? custom;

  TemplatesDto({
    this.predefined,
    this.custom,
  });

  @override
  TemplatesDto fromJson(Map<String, dynamic> json) {
    return TemplatesDto(
      predefined: (json['predefined'] as List?)
          ?.map((e) => TemplateDto().fromJson(e as Map<String, dynamic>))
          .toList(),
      custom: (json['custom'] as List?)
          ?.map((e) => CustomTemplateDto().fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(TemplatesDto object) {
    return {
      'predefined': object.predefined?.map((e) => e.toJson(
        object.predefined!.firstWhere((element) => element.name == e.name, orElse: () => e),
      )).toList(),
      'custom': object.custom?.map((e) => e.toJson(
        object.custom!.firstWhere((element) => element.id == e.id, orElse: () => e),
      )).toList(),
    };
  }

  TemplatesEntity toEntity() {
    return TemplatesEntity(
      predefined: predefined?.map((e) => e.toEntity()).toList() ?? [],
      custom: custom?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}