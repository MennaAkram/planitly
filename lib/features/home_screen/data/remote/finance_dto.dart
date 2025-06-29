import 'package:planitly/shared/bases/base_mapper.dart';
import '../../domain/entity/finance_entity.dart';
import 'component_dto.dart';
import 'subject_dto.dart';

class FinanceDto extends BaseMapper<FinanceDto> {
  SubjectDto? subject;
  List<ComponentsDto>? components;
  List<String>? widgets;

  FinanceDto({
    this.subject,
    this.components,
    this.widgets,
  });

  @override
  Map<String, dynamic> toJson(FinanceDto object) {
    return {
      'subject': object.subject?.toJson(object.subject!),
      'components': object.components?.map((e) => e.toJson(e)).toList(),
      'widgets': object.widgets,
    };
  }

  @override
  FinanceDto fromJson(Map<String, dynamic> json) {
    return FinanceDto(
      subject: json['subject'] != null
          ? SubjectDto().fromJson(json['subject'] as Map<String, dynamic>)
          : null,
      components: (json['components'] as List<dynamic>?)
          ?.map((e) => ComponentsDto().fromJson(e as Map<String, dynamic>))
          .toList(),
      widgets: (json['widgets'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  FinanceEntity toEntity() {
    return FinanceEntity(
      subject: subject!.toEntity(),
      components: components?.map((e) => e.toEntity()).toList() ?? [],
      widgets: widgets ?? [],
    );
  }
}