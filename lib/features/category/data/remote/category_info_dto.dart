import 'package:planitly/features/category/domain/entity/category_info_entity.dart';
import 'package:planitly/features/my_pages/data/remote/pages_info_dto.dart';
import 'package:planitly/features/my_pages/domain/entity/pages_info_entity.dart';
import 'package:planitly/shared/bases/base_mapper.dart';

class CategoryInfoDto extends BaseMapper<CategoryInfoDto> {
  PagesInfoEntity? pagesInfo;

  CategoryInfoDto({
    this.pagesInfo,
  });

  @override
  CategoryInfoDto fromJson(Map<String, dynamic> json) {
    return CategoryInfoDto(
      pagesInfo: PagesInfoDto().fromJson(json).toEntity(),
    );
  }

  @override
  Map<String, dynamic> toJson(CategoryInfoDto object) {
    return {
      'pages_info': object.pagesInfo,
    };
  }

  CategoryInfoEntity toEntity() {
    return CategoryInfoEntity(
      pagesInfo: pagesInfo ?? PagesInfoEntity(total: 0, pages: []),
    );
  }
}
