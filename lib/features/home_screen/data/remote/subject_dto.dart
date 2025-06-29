import 'package:planitly/features/home_screen/domain/entity/subject_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class SubjectDto extends BaseMapper<SubjectDto> {
  String? id;
  String? name;
  String? template;
  String? category;
  List<String>? components;
  List<String>? widgets;
  bool? isDeletable;
  String? owner;
  DateTime? createdAt;
  int? timesVisited;
  DateTime? lastVisited;

  SubjectDto({
    this.id,
    this.name,
    this.template,
    this.category,
    this.components,
    this.widgets,
    this.isDeletable,
    this.owner,
    this.createdAt,
    this.timesVisited,
    this.lastVisited,
  });

  @override
  Map<String, dynamic> toJson(SubjectDto object) {
    return {
      'id': object.id,
      'name': object.name,
      'template': object.template,
      'category': object.category,
      'components': object.components,
      'widgets': object.widgets,
      'is_deletable': object.isDeletable,
      'owner': object.owner,
      'created_at': object.createdAt?.toIso8601String(),
      'times_visited': object.timesVisited,
      'last_visited': object.lastVisited?.toIso8601String(),
    };
  }

  @override
  SubjectDto fromJson(Map<String, dynamic> json) {
    return SubjectDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      template: json['template'] as String?,
      category: json['category'] as String?,
      components: (json['components'] as List<dynamic>?)?.map((e) => e as String).toList(),
      widgets: (json['widgets'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isDeletable: json['is_deletable'] as bool?,
      owner: json['owner'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      timesVisited: json['times_visited'] as int?,
      lastVisited: json['last_visited'] != null ? DateTime.parse(json['last_visited']) : null,
    );
  }

  SubjectEntity toEntity() {
    return SubjectEntity(
      id: id ?? '',
      name: name ?? '',
      template: template ?? '',
      category: category ?? '',
      components: components ?? [],
      widgets: widgets ?? [],
      isDeletable: isDeletable ?? false,
      owner: owner ?? '',
      createdAt: createdAt ?? DateTime.now(),
      timesVisited: timesVisited ?? 0,
      lastVisited: lastVisited ?? DateTime.now(),
    );
  }
}