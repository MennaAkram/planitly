import 'package:planitly/features/categories/domain/entity/category_entity.dart';

class CategoriesInfoEntity {
  final int total;
  final List<CategoryEntity> categories;

  CategoriesInfoEntity({
    required this.total,
    required this.categories,
  });
}
