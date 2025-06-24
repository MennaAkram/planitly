import 'package:planitly/features/categories/data/remote/category_dto.dart';
import 'package:planitly/features/categories/domain/entity/categories_info_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class CategoriesInfoDto extends BaseMapper<CategoriesInfoDto> {
  int? total;
  List<CategoryDto>? categories;

  CategoriesInfoDto({this.total, this.categories});

  @override
  CategoriesInfoDto fromJson(Map<String, dynamic> json) {
    return CategoriesInfoDto(
      total: json['total'] as int?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryDto().fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson(CategoriesInfoDto object) {
    return {
      'total': object.total,
      'categories': object.categories?.map((e) => e.toJson(e)).toList(),
    };
  }

  CategoriesInfoEntity toEntity() {
    return CategoriesInfoEntity(
      total: total ?? 0,
      categories: categories?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
