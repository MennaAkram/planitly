import 'package:planitly/features/categories/domain/entity/category_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class CategoryDto extends BaseMapper<CategoryDto> {
  String? id;
  String? name;

  CategoryDto({this.id, this.name});

  @override
  CategoryDto fromJson(Map<String, dynamic> json) {
    return CategoryDto(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson(CategoryDto object) {
    return {
      'id': object.id,
      'name': object.name,
    };
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id ?? '',
      name: name ?? '',
    );
  }
}
