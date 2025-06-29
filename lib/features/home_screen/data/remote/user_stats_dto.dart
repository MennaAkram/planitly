import 'package:planitly/features/home_screen/domain/entity/user_stats_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class UserStatsDto extends BaseMapper<UserStatsDto> {
  int? totalSubjects;
  int? totalCategories;
  int? totalConnections;

  UserStatsDto({
     this.totalSubjects,
     this.totalCategories,
     this.totalConnections,
  });

  @override
  Map<String, dynamic> toJson(UserStatsDto object) {
    return {
      'total_subjects': object.totalSubjects,
      'total_categories': object.totalCategories,
      'total_connections': object.totalConnections,
    };
  }

  @override
  UserStatsDto fromJson(Map<String, dynamic> json) {
    return UserStatsDto(
      totalSubjects: json['total_subjects'],
      totalCategories: json['total_categories'],
      totalConnections: json['total_connections'],
    );
  }

  UserStatsEntity toEntity() {
    return UserStatsEntity(
      totalSubjects: totalSubjects ?? 0,
      totalCategories: totalCategories ?? 0,
      totalConnections: totalConnections ?? 0,
    );
  }
}