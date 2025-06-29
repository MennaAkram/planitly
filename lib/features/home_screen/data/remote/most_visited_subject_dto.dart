import 'package:planitly/features/home_screen/domain/entity/most_visited_subject_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class MostVisitedSubjectDto extends BaseMapper<MostVisitedSubjectDto> {
  String? id;
  String? name;
  String? category;
  String? template;
  int? timesVisited;
  DateTime? lastVisited;

  MostVisitedSubjectDto({
    this.id,
    this.name,
    this.category,
    this.template,
    this.timesVisited,
    this.lastVisited,
  });

  @override
  MostVisitedSubjectDto fromJson(Map<String, dynamic> json) {
    return MostVisitedSubjectDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      template: json['template'] as String?,
      timesVisited: json['times_visited'] as int?,
      lastVisited: json['last_visited'] != null
          ? DateTime.parse(json['last_visited'] as String)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson(MostVisitedSubjectDto object) {
    return {
      'id': object.id,
      'name': object.name,
      'category': object.category,
      'template': object.template,
      'times_visited': object.timesVisited,
      'last_visited': object.lastVisited?.toIso8601String(),
    };
  }

  MostVisitedSubjectEntity toEntity() {
    return MostVisitedSubjectEntity(
      id: id ?? '',
      name: name ?? '',
      category: category ?? '',
      template: template ?? '',
      timesVisited: timesVisited ?? 0,
      lastVisited: lastVisited ?? DateTime.now(),
    );
  }
}