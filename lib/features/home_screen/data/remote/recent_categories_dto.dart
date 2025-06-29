import 'package:planitly/features/home_screen/domain/entity/recent_categories_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class RecentCategoriesDto extends BaseMapper<RecentCategoriesDto> {
  String? id;
  String? name;
  int? subjectsCount;
  DateTime? createdAt;

  RecentCategoriesDto({
    this.id,
    this.name,
    this.subjectsCount,
    this.createdAt,
  });

  @override
  RecentCategoriesDto fromJson(Map<String, dynamic> json) {
    return RecentCategoriesDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
      subjectsCount: json['subjects_count'] as int?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson(RecentCategoriesDto object) {
    return {
      'id': object.id,
      'name': object.name,
      'subjects_count': object.subjectsCount,
      'created_at': object.createdAt?.toIso8601String(),
    };
  }

  RecentCategoriesEntity toEntity() {
    return RecentCategoriesEntity(
      id: id ?? '',
      name: name ?? '',
      subjectsCount: subjectsCount ?? 0,
      createdAt: createdAt ?? DateTime.now(),
    );
  }
}