import 'package:planitly/features/subject/data/remote/property_dto.dart';
import 'package:planitly/features/subject/domain/entity/subject_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class SubjectDto extends BaseMapper<SubjectDto> {
  String? id;
  String? name;
  String? templete;
  String? category;
  List<PropertyDto>? properties;

  SubjectDto({
    this.id,
    this.name,
    this.templete,
    this.category,
    this.properties,
  });

  @override
  SubjectDto fromJson(Map<String, dynamic> json) {
    return SubjectDto(
      id: json['subject']['id'] as String?,
      name: json['subject']['name'] as String?,
      templete: json['subject']['templete'] as String?,
      category: json['subject']['category'] as String?,
      properties: (json['components'] as List)
          .map((property) =>
              PropertyDto().fromJson(property as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(SubjectDto object) {
    return {
      'id': object.id,
      'name': object.name,
      'templete': object.templete,
      'category': object.category,
      'properties':
          object.properties?.map((e) => PropertyDto().toJson(e)).toList(),
    };
  }

  SubjectEntity toEntity() {
    return SubjectEntity(
      id: id ?? '',
      name: name ?? '',
      templete: templete ?? '',
      category: category ?? '',
      properties: properties?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
